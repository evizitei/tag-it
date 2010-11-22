require "observer"
require "timeout"

module TagIt
  class TagTracker  < TagIt::Monitor
    include Observable
    include Timeout
    
    def initialize(port)
      super(port)
      @tag_map ||= {}
    end
    
    def start!
      begin
        monitor_tags do |tag_name,strength|
          flush_tag!(tag_name,strength)
          depart_dormant_tags!
        end
      rescue Timeout::Error
        depart_all_tags!
      end
    end
    
    def flush_tag!(tag_name,strength)
      if @tag_map[tag_name].nil?
        changed
        notify_observers(tag_name,strength,:tag_arrived)
      end
      @tag_map[tag_name] = Time.now
    end
    
    def depart_all_tags!
      @tag_map.keys.each do |tag_name|
        changed
        notify_observers(tag_name,0,:tag_departed)
      end
      @tag_map.clear
    end
    
    def depart_dormant_tags!
      tags_to_depart = []
      @tag_map.each do |tag_name,last_time|
        tags_to_depart << tag_name if((Time.now - last_time) > 8)
      end
      
      tags_to_depart.each do |tag_name|
        changed
        notify_observers(tag_name,0,:tag_departed)
        @tag_map.delete(tag_name)
      end
    end
    
    def pulse!
      changed
      notify_observers(@tag_map.keys.sort,0,:pulse)
      @last_pulse = Time.now
    end
  end
end
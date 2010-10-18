require "observer"
require "timeout"

module TagIt
  class TagTracker
    include Observable
    include Timeout
    
    def initialize(port)
      @port = port
      @tag_map ||= {}
    end
    
    def start!
      char = nil
      tag_name = ""
      
      #dont start reporting until after the first space, 
      #so we don't have to deal with partial tagnames
      clean_start_flag = false 
      
      #128 is the stop character we're adding so the tests can cutoff the loop.  
      #Production will loop infinitely until shutdown
      while char != 128  
        begin
          # Don't take longer than 3 seconds to find a char, or there aren't any
          Timeout::timeout(3) do
            char = @port.getc
          end
          if char == 32 
            flush_tag!(tag_name) if clean_start_flag #don't send until after first space
            depart_dormant_tags!
            tag_name = ""
            clean_start_flag = true #here's a space, start sending tags
          else
            tag_name = "#{tag_name}#{char.chr}"
          end
        rescue Timeout::Error
          depart_all_tags!
        end
      end
    end
    
    def flush_tag!(tag_name)
      tag_name,strength = split_tag_data(tag_name)
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
    
    def split_tag_data(tag_name)
      [tag_name[0,4],tag_name[4,tag_name.size - 4].to_i]
    end
  end
end
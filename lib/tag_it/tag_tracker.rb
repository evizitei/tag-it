require "observer"
module TagIt
  class TagTracker
    include Observable
    
    def initialize(port)
      @port = port
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
        char = @port.getc
        if char == 32 
          flush_tag!(tag_name) if clean_start_flag #don't send until after first space
          tag_name = ""
          clean_start_flag = true #here's a space, start sending tags
        else
          tag_name = "#{tag_name}#{char.chr}"
        end  
      end
    end
    
    def flush_tag!(tag_name)
      tag_name,strength = split_tag_data(tag_name)
      @tag_map ||= {}
      if @tag_map[tag_name].nil?
        @tag_map[tag_name] = Time.now
        changed
        notify_observers(tag_name,strength,:tag_arrived)
      end
    end
    
    def split_tag_data(tag_name)
      [tag_name[0,4],tag_name[4,tag_name.size - 4].to_i]
    end
  end
end
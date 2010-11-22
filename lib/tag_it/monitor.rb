module TagIt
  class Monitor
    attr_accessor :port
    
    def initialize(local_port)
      self.port = local_port
      @last_pulse = Time.now
    end
    
    def monitor_tags
      char = nil
      tag_name = ""
      #dont start reporting until after the first space, 
      #so we don't have to deal with partial tagnames
      clean_start_flag = false 
      
      #128 is the stop character we're adding so the tests can cutoff the loop.  
      while char != 128  
        # Don't take longer than 3 seconds to find a char, or there aren't any
        Timeout::timeout(3) do
          char = @port.getc
        end
        if char == 32 
          name,strength = split_tag_data(tag_name)
          yield(name,strength) if clean_start_flag
          tag_name = ""
          clean_start_flag = true #here's a space, start sending tags
        else
          tag_name = "#{tag_name}#{char.chr}"
        end
        if ((Time.now - 180) > @last_pulse)
          self.pulse!
        end
      end
    end
    
    def split_tag_data(tag_name)
      [tag_name[0,4],tag_name[4,tag_name.size - 4].to_i]
    end
    
    def pulse!
      #do nothing, you can override in a subclass if you want to fire an event or something
    end
  end
end
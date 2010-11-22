module TagIt
  class TagSnapshot < TagIt::Monitor
    
    def shoot!
      tags = []
      begin 
        monitor_tags do |tag_name,strength|
          return tags if !tags.index(tag_name).nil?
          tags << tag_name
        end
      rescue Timeout::Error
        #do nothing, let tags return
      end
      tags
    end
  end
end
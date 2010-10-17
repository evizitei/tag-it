require 'helper'

class TestTagTracker < Test::Unit::TestCase
  context "TagTracker" do
    should "report full tag names" do
      data = " 1nri85 1nwP79 "
      watcher = TagObserver.new
      watcher.expects(:update).with("1nri",85,:tag_arrived).times(1)
      watcher.expects(:update).with("1nwP",79,:tag_arrived).times(1)
      check_data_extract(data,watcher)
    end
    
    should "only report tags after the first space" do
      data = "P79 1m2342 1ksR81 "
      watcher = TagObserver.new
      watcher.expects(:update).with("1m23",42,:tag_arrived).times(1)
      watcher.expects(:update).with("1ksR",81,:tag_arrived).times(1)
      check_data_extract(data,watcher)
    end
    
    should "only report each individual tag the first time" do
      data = " 1nri85 1nwP79 1nri85 1nwP79 1nri85 1nwP79 "
      watcher = TagObserver.new
      watcher.expects(:update).with("1nri",85,:tag_arrived).times(1)
      watcher.expects(:update).with("1nwP",79,:tag_arrived).times(1)
      check_data_extract(data,watcher)
    end
  end
  
  def check_data_extract(data,watcher)
    port = MockSerialPort.new(data)
    tracker = TagIt::TagTracker.new(port)
    tracker.add_observer(watcher)
    tracker.start!
  end
end

class TagObserver
  def update(tag_id,strength,event)
  end
end
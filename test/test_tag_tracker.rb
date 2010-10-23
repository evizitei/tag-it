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
    
    should "clear send out departing events when no tags in range" do
      data = " 1nri85 1nwP79 1nri85 1nwP79 1nri85 1nwP79 "
      watcher = TagObserver.new
      watcher.expects(:update).with("1nri",85,:tag_arrived).times(1)
      watcher.expects(:update).with("1nwP",79,:tag_arrived).times(1)
      watcher.expects(:update).with("1nri",0,:tag_departed).times(1)
      watcher.expects(:update).with("1nwP",0,:tag_departed).times(1)
      check_data_extract(data,watcher,TimeoutSerialPort)
    end
    
    should "dispatch a departing event when one tag leaves" do
      data = " 1nri85 1nwP79 1nwP79 1nwP79 1nwP79 1nwP79 1nwP79 1nwP79 1nwP79 1nwP79 "
      watcher = TagObserver.new
      watcher.expects(:update).with("1nri",85,:tag_arrived).times(1)
      watcher.expects(:update).with("1nwP",79,:tag_arrived).times(1)
      watcher.expects(:update).with("1nri",0,:tag_departed).times(1)
      check_data_extract(data,watcher,PacingSerialPort)
    end
    
    should "dispatch a heartbeat event every 180 seconds" do
      start_time = Time.local(2008, 9, 1, 12, 0, 0)
      end_time = start_time + 300
      Timecop.freeze(start_time)
      data = " 1nri85 1nwP79 "
      watcher = TagObserver.new
      watcher.expects(:update).with("1nri",85,:tag_arrived).times(1)
      watcher.expects(:update).with("1nwP",79,:tag_arrived).times(1)
      watcher.expects(:update).with(["1nri","1nwP"],0,:pulse).times(1)
      port = MockSerialPort.new(data)
      tracker = TagIt::TagTracker.new(port)
      tracker.add_observer(watcher)
      tracker.start!
      Timecop.travel(end_time)
      tracker.start!
      Timecop.return
    end
  end
  
  def check_data_extract(data,watcher,port_mocker = MockSerialPort)
    port = port_mocker.new(data)
    tracker = TagIt::TagTracker.new(port)
    tracker.add_observer(watcher)
    tracker.start!
  end
end

class TagObserver
  def update(tag_id,strength,event)
  end
end
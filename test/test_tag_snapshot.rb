require 'helper'

class TestTagSnapshot < Test::Unit::TestCase
  context "TagSnapshot" do
    should "report all tag names in range" do
      data = " 1nri85 1nwP79 1okD01 "
      snapshot = TagIt::TagSnapshot.new(MockSerialPort.new(data))
      assert_equal ["1nri","1nwP","1okD"],snapshot.shoot!
    end
    
    should "return on repeat" do
      data = " 1nri85 1nwP79 1okD01 1nri72 1nwP79 1okD01 "
      snapshot = TagIt::TagSnapshot.new(MockSerialPort.new(data))
      assert_equal ["1nri","1nwP","1okD"],snapshot.shoot!
    end
    
    should "return empty if no tags" do
      snapshot = TagIt::TagSnapshot.new(TimeoutSerialPort.new(""))
      assert_equal [],snapshot.shoot!
    end
  end
end
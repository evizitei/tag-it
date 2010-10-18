class MockSerialPort
  def initialize(data)
    @data = []
    data.each_byte{|b| @data << b}
    @data << 128
  end
  
  def getc
    char = @data.delete_at 0
    char_hook(char)
    char = 128 if char.nil?
    return char
  end
  
  def char_hook(char)
    #do nothing
  end
end

class TimeoutSerialPort < MockSerialPort
  def char_hook(char)
    if char == 128
      sleep(5)
    end
  end
end

class PacingSerialPort < MockSerialPort
  def char_hook(char)
    if char == 32
      sleep(1)
    end
  end
end
class MockSerialPort
  def initialize(data)
    @data = []
    data.each_byte{|b| @data << b}
    @data << 128
  end
  
  def getc
    char = @data.delete_at 0
    return char
  end
end
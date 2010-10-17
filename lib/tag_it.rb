require 'rubygems'
require 'bundler/setup'
require 'serialport'
require 'tag_it/tag_tracker'

# port = SerialPort.new("/dev/tty.usbserial",:baud=>9600,:data_bits=>8,:stop_bits=>1)
# 
# count = 0
# while count < 1000
#   printf("%c",port.getc)
#   count += 1
# end

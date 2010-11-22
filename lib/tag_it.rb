require 'rubygems'
require 'bundler/setup'
require 'serialport'

module TagIt
  autoload :TagTracker,"tag_it/tag_tracker.rb"
  autoload :TagSnapshot,"tag_it/tag_snapshot.rb"
  autoload :Monitor,"tag_it/monitor.rb"
end

# port = SerialPort.new("/dev/tty.usbserial",:baud=>9600,:data_bits=>8,:stop_bits=>1)
# 
# count = 0
# while count < 1000
#   printf("%c",port.getc)
#   count += 1
# end

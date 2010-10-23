require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'mock_serial_port'
require 'timecop'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'tag_it'

class Test::Unit::TestCase
end

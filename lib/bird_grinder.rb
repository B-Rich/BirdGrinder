lib_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)
require 'perennial'
require 'yajl'
require 'eventmachine'
require 'em-http'

module BirdGrinder
  include Perennial
  
  VERSION = [0, 1, 5, 0]

  def self.version(include_minor = false)
    VERSION[0, (include_minor ? 4 : 3)].join(".")
  end
  
  manifest do |m, l|
    Settings.lookup_key_path = []
    Settings.root = __FILE__.to_pathname.dirname.dirname
    l.register_controller :client,  'BirdGrinder::Client'
    l.register_controller :console, 'BirdGrinder::Console'
  end
  
  has_library :cacheable, :tweeter, :client, :base, :command_handler, :console, :stream_handler
  
  extends_library :loader
  
  autoload :QueueProcessor, 'bird_grinder/queue_processor'
  
end

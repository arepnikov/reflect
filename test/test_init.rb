ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'record_invocation'
require 'test_bench'; TestBench.activate

require 'pp'
require 'securerandom'

require 'reflect/controls'
Controls = Reflect::Controls

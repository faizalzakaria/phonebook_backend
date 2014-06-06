# -*- coding: utf-8 -*-
require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec'
require 'rack/test'
require 'webmock/rspec'

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

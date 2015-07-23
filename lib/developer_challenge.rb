require 'developer_challenge/version'
require 'developer_challenge/slow_api'
require 'developer_challenge'

::DeveloperChallenge::SlowApi.start(ARGV)

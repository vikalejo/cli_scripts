require 'developer_challenge/version'
require 'developer_challenge/cli/slow_api'
require 'developer_challenge'

::DeveloperChallenge::Cli::SlowApi.start(ARGV)

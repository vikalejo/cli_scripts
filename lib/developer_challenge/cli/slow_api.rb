require 'thor'

module DeveloperChallenge
  module Cli
    class SlowApi < Thor

      desc 'Request url', 'make n times a request to a Novicap url'
      def request_service
        puts 'some request to Novicap'
      end
    end
  end
end

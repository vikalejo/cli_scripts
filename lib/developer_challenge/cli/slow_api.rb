require 'thor'
require 'net/http'

module DeveloperChallenge
  module Cli
    class SlowApi < Thor
      URL_SLOWAPI = URI('http://www.slowapi.com/delay/0.3')

      desc 'Slowapi -n [number]', 'make n times a request to a Novicap url'
      method_option :test
      method_option :number, :aliases => "-n"

      # Checks if the option 'test' is received to run
      # If received, will call do_request with the number of times passed
      def slowapi
        if correct_options?(options)
            times = options[:number].to_i
            puts "Starting request to slowapi"
          begin
            do_request_and_write_response(times)
          rescue => e
            puts 'Some problem occurred when connecting to Slowapi, try later'
            return false
          end
        else
          puts "Some parameter is missing or not valid, you need to run it, like this:" \
            'development_challenge slowapi --test -n 300'
          return false
        end
      end

      private

      def correct_options?(options)
        test = options[:test]
        times = options[:number].to_i
        (test && times && times > 0) ? true : false
      end

      # Do requests to slowapi the number of times received in options
      def do_request_and_write_response(times)
        File.open('response_log.txt', 'a+') do |file|
          (1..times).each do |iteration|
            response = do_request_to_slowapi
            file.puts("response_#{iteration}: " + response.body)
          end
          puts 'Done!'
          return true
        end
      end

      def do_request_to_slowapi
        Net::HTTP.get_response(URL_SLOWAPI)
      end
    end
  end
end

require 'net/http'

module DeveloperChallenge
  class SlowApi
    URL_SLOWAPI = URI('http://www.slowapi.com/delay/0.3')

    # Checks if the option 'test' is received to run
    # If received, will call do_request with the number of times passed
    def slowapi(number)
      if correct_number?(number)
        times = number.to_i
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

    def correct_number?(number)
      number = number.to_i
      (number > 0) ? true : false
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

require 'thor'
require 'net/http'

module DeveloperChallenge
  class MinimumPathSum < Thor
    desc 'Minimum_path_sum -f [file]', 'find minimum path sum'
    method_option :test
    method_option :file, :aliases => "-f"


  end
end


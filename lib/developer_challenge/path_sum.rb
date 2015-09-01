require 'thread'

module DeveloperChallenge
  class PathSum
    def minimum_path_sum(file)
      read_structure(file) unless !File.exist?("data/#{file}")
      abort "The file does not exist"
    end

    def read_structure(file)
      line_num=0
      data_triangle = File.read("data/#{file}")
      triangle = data_triangle.each_line.map do |line|
        line.split.map(&:to_i)
      end

      get_and_print_result(triangle)
      exit
    end

    def get_and_print_result(triangle)
      result = sum_path(triangle)

      # Print the result
      result_minimun_sum_path(result.min)
      result_sum_last_element_path(result.last)
    end

    def sum_path(triangle)
      partial = []
      i,j= 0,0

      tmp = triangle
      (1...tmp.size).each do |i|
        (0...tmp.size).each do |j|
          if j == 0
            tmp[i][j] = tmp[i][j] + triangle[i-1][j] if !triangle[i-1][j].nil?
          else
            from_up   = tmp[i][j] + triangle[i-1][j] if !triangle[i-1][j].nil?
            from_left = tmp[i][j] + triangle[i-1][j-1] if !triangle[i-1][j-1].nil?
            tmp[i][j] = if from_up.nil?
                          from_left if !from_left.nil?
                        else
                          tmp[i][j] = from_up > from_left ? from_left : from_up
                        end
          end
        end
      end
      tmp.last
    end

    def result_sum_last_element_path(minimum_value)
      puts "The sum from the top to the bottom of the last value is #{minimum_value}"
    end

    def result_minimun_sum_path(minimun_value)
      puts "The minimun sum from the top to the bottom is #{minimun_value}"
    end
  end
end


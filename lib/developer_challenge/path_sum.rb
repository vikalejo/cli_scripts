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
      last_array = result.last

      # Print the result
      result_minimum_sum_path(result.flatten!.min)
      result_sum_last_element_path(last_array.last)
    end

    # Calculates the sum between the elements of the structure
    def sum_path(triangle)
      sum = []
      partial = []

      triangle.inject([]) do |res, x|
        if sum.empty?
          sum << x
        else
          sum.each do |element|
            # Check if is an array to allow work with isolate values
            if element.is_a?(Array)
              element.each_with_index do |ae, ine|
                partial << iterate_with_array(x, ae, ine)
              end
            else
              partial = iterate_with_array(x, element, ine)
              sum = partial
              res = sum
            end
          end

          sum = partial
          partial = []
          res = sum
        end
      end
    end

    # Iterates with each element of the lines of the triangle
    # only if the values are adjacents
    def iterate_with_array(x, ae, ine)
      acumulate = []
      x.each_with_index do |value, index|
        acumulate << ([ae + value]) if adjacent?(index,ine)

        # This will force to do the last iteration
        if index == x.size - 1
          acumulate << ([ae + value]) if adjacent?(index,ine)
        end
      end
      acumulate.flatten!
    end

    def adjacent?(inx, ine)
      diff = (inx - ine).abs
      (diff == 0) || (diff == 1) ? true : false
    end

    def result_sum_last_element_path(minimum_value)
      puts "The sum from the top to the bottom of the last value is #{minimum_value}"
    end

    def result_minimum_sum_path(minimum_value)
      puts "The minimum sum from the top to the bottom is #{minimum_value}"
    end
  end
end


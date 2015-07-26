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
      sum_path(triangle)
      exit
    end

    def sum_path(triangle)
      puts triangle.inject([]) { |res,x|
        print " res es: #{res}"
        print " x es: #{x}"
        minima = [0, *res, 0].each_cons(2).map(&:min)
        puts " minima es: #{minima}"
        x.zip(minima).map{ |a,b| a+b }
      }
    end
  end
end


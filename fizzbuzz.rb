
class FizzBuzz
  attr_reader :fizz_factor, :buzz_factor, :string_of_digits, :series_of_numbers
  def initialize(args = {})
    @string_of_digits = args.fetch(:string_of_digits)
    @parsed_string_of_digits = []
    @series_of_numbers = []
    @fizz_factor = 0
    @buzz_factor = 0
  end

  def run
    self.parse_string_to_digits
    self.create_series
    self.set_fizz
    self.set_buzz

    @series_of_numbers.map! do |number|
      if fizzbuzz_test(number) == true
        number = "FB"
      elsif fizz_test(number) == true
        number = "F"
      elsif buzz_test(number) == true
        number = "B"
      else
        number
      end
    end

  end

  def parse_string_to_digits
    @parsed_string_of_digits = @string_of_digits.split(" ").map do |digit|
      digit.to_i
    end
  end

  def create_series
    @series_of_numbers = (1..@parsed_string_of_digits[2]).to_a
  end

  def set_fizz
    @fizz_factor = @parsed_string_of_digits[0]
  end

  def set_buzz
    @buzz_factor = @parsed_string_of_digits[1]
  end

  def fizz_test(number)
    number % @fizz_factor == 0 ? true : false
  end

  def buzz_test(number)
    number % @buzz_factor == 0 ? true : false
  end

  def fizzbuzz_test(number)
    number % @fizz_factor == 0 && number % @buzz_factor == 0 ? true : false
  end
end

class View
  class << self
    def show_fizz_factor(fizzbuzz_object)
      puts "Fizz: #{fizzbuzz_object.fizz_factor}"
    end

    def show_buzz_factor(fizzbuzz_object)
      puts "Buzz: #{fizzbuzz_object.buzz_factor}"
    end

    def show_series(fizzbuzz_object)
      puts fizzbuzz_object.series_of_numbers.join(" ")
    end



  end
end


class Controller
  def run

    fizzbuzz_collection = []

    File.open(ARGV[0]).each_line do |line|
      fizzbuzz_collection << FizzBuzz.new({string_of_digits: line})
    end

    fizzbuzz_collection.each do |fizzbuzz|
      fizzbuzz.run
      View.show_series(fizzbuzz)
    end

  end
end

Controller.new.run

require_relative 'lib/Tax'

Tax.new('input_files/input_1.txt').execute
puts ''
Tax.new('input_files/input_2.txt').execute
puts ''
Tax.new('input_files/input_3.txt').execute
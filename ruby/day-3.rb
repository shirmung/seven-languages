# notes

class Roman
  def self.method_missing(name, *args)
    roman = name.to_s
    roman.gsub!('IV', 'IIII')
    roman.gsub!('IX', 'VIIII')
    roman.gsub!('XL', 'XXXX')
    roman.gsub!('XC', 'LXXXX')

    (roman.count('I') +
     roman.count('V') * 5 +
     roman.count('X') * 10 +
     roman.count('L') * 50 +
     roman.count('C') * 100)
  end
end

puts Roman.X
puts Roman.XC
puts Roman.XII
puts Roman.X
puts Roman.IV

module ActsAsCSV
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @rows = []
      file = File.new("#{self.class.to_s.downcase}.txt")
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        contents = row.chomp.split(', ')
        @rows << CSVRow.new(@headers, contents)
      end
    end

    def each(&block)
      @rows.each(&block)
    end
  end

  attr_accessor :headers, :rows

  def initialize
    read
  end
end

class CSVRow
  attr_accessor :columns

  def initialize(headers, contents)
    @columns = {}

    headers.each_with_index do |header, index|
      @columns[header] = contents[index]
    end
  end

  def method_missing(name, *args)
    @columns[name.to_s]
  end
end

class RubyCSV
  include ActsAsCSV
  acts_as_csv
end

csv = RubyCSV.new

csv.each do |row|
  puts row.two
end

require 'date'

class Person
  attr_accessor :last, :first, :gender, :color, :birth
  def initialize(last, first, gender, color, birth)
    @last = last
    @first = first
    @gender = gender_s(gender)
    @color  = color
    @birth = birth
  end

  def gender_s(g)
    g = "Male" if g == "M"
    g = "Female" if g == "F"
    g
  end

  def to_s
    "#{last} #{first} #{gender} #{birth.strftime("%-m/%-d/%Y")} #{color}"
  end
end


def split_comma(line)
  info = line.split(", ")
  Person.new(info[0], info[1], info[2], info[3], Date.strptime(info[4], '%m/%d/%Y'))
end

def split_pipe(line)
  info = line.split(" | ")
  Person.new(info[0], info[1], info[3], info[4], Date.strptime(info[5], '%m-%d-%Y'))
end

def split_space(line)
  info = line.split(" ")
  Person.new(info[0], info[1], info[3], info[5], Date.strptime(info[4], '%m-%d-%Y'))
end

if __FILE__ == $0
  # Drive code
  staff = []
  lines = File.new('sample/comma.txt').read.split("\n")
  lines.each do |line|
    staff << split_comma(line)
  end
  lines = File.new('sample/pipe.txt').read.split("\n")
  lines.each do |line|
    staff << split_pipe(line)
  end
  lines = File.new('sample/space.txt').read.split("\n")
  lines.each do |line|
    staff << split_space(line)
  end

  puts "Output 1:"
  puts staff.sort_by { |p| [p.gender, p.last] }

  puts "\nOutput 2:"
  puts staff.sort_by { |p| p.birth }

  puts "\nOutput 3:"
  puts staff.sort { |x, y| y.last <=> x.last }

end

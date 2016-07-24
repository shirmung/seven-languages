# notes

# interpreted - code is executed by an interpreter rather than a compiler

# dynamically typed - types are bound at execution time rather than compile time (flexibility vs safety)

# object-oriented - supports encapsulation (data and behavior packaged together), inheritance through classes (object types are organized in a class tree), polymorphism (objects can take many forms)

# ruby: interpreted, object-oriented, dynamically typed (duck typed)

# ! higher order functions (accepts functions as arguments or returns functions), first class functions (can be treated as arguments or returned or stored in variables)

# self-study

puts 'hello world'

string = 'hello ruby'

first_char = string[0]
puts first_char

first_char = string.slice(0)
puts first_char

first_char = string.chars.first
puts first_char

(0..9).each do |i|
  puts 'shirmung'
end

(1..10).each do |i|
  puts "this is sentence number #{i}"
end

random_num = rand(10)

puts 'guess the random number between 0 and 9'
guess = gets

if guess.to_i == random_num
  puts "correct, the random number is #{random_num}"
else
  puts "incorrect, the random number is #{random_num}"
end

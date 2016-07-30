# notes

module ToFile # mixin, packaging of behavior
  def file_name
    "object_#{self.object_id}_#{self.name}.txt" # self not necessary
  end

  def to_f
    File.open(file_name, 'w') do |f|
      f.write(to_s)
    end
  end
end

class Person
  include ToFile
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end
end

Person.new('shirmung').to_f

a = [20, 10, 23, 1, 45]

a.inject(5) do |sum, i|
  puts "sum: #{sum}, i: #{i}, sum + i: #{sum + i}"
  sum + i
end

# self-study

(1..16).each do |i|
  if i % 4 == 0
    puts "#{i - 4} #{i - 3} #{i - 2} #{i - 1}"
  end
end

(1..16).each_slice(4) do |num1, num2, num3, num4|
  puts "#{num1} #{num2} #{num3} #{num4}"
end

class Tree
  attr_accessor :node_name, :children

  # original way of initialization

  # def initialize
  #   @node_name = node_name
  #   @children = children
  # end

  # first attempt, doesn't support original way of initialization

  # def initialize(hash)
  #   hash.each do |key, value|
  #     @node_name = key
  #     @children = []

  #     value.each do |k, v|
  #       @children << Tree.new({k => v})
  #     end
  #   end
  # end

  def initialize(node_name, children=[])
    if node_name.respond_to?('keys')
      root_node = node_name.first
      node_name = root_node[0]
      children = root_node[1]
    end

    if children.respond_to?('keys')
      children = children.map do |child_name, grandchildren|
        Tree.new(child_name, grandchildren)
      end
    end

    @node_name = node_name
    @children = children
  end

  def visit_all(&block) # code block vs variable called block
    visit &block
    children.each do |c|
      c.visit_all(&block) # recursion
    end
  end

  def visit(&block)
    block.call self
  end
end

ruby_tree = Tree.new('father', [Tree.new('child 1'), Tree.new('child 2')])

puts 'visiting a node'

ruby_tree.visit do |node|
  puts node.node_name
end

puts 'visiting entire tree'

ruby_tree.visit_all do |node|
  puts node.node_name
end

ruby_tree = Tree.new({
  'grandfather' => {
    'father' => {
      'child 1' => {},
      'child 2' => {}
    },
    'uncle' => {
      'child 3' => {},
      'child 4' => {}
    }
  }
})

puts 'visiting a node'

ruby_tree.visit do |node|
  puts node.node_name
end

puts 'visiting entire tree'

ruby_tree.visit_all do |node|
  puts node.node_name
end

def grep(pattern, file_name)
  file = File.new(file_name)

  file.each_with_index do |row, index|
    if row =~ /#{pattern}/
      puts "#{index}: #{row.chomp}"
    end
  end
end

grep('blue', 'rubycsv.txt')

class Tree
  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree(array)

  end

  def sort(array)

  end

  def remove_duplicates(array)

  end
end

class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def to_s
    "Node with value: #{value}"
  end
end

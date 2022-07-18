class LinkedList
  def initialize
    @head = nil
  end

  def is_empty?
    @head == nil ? true : false
  end

  def append(value)
    # if the linked list is empty, create a head node
    if self.is_empty?
      @head = Node.new(value)
    else
      # start at the head and create a new node
      current_node = @head
      new_node = Node.new(value)
      # keep following the linked list until it's the last one (i.e. the next value is nil)
      until current_node.next == nil
        current_node = current_node.next
      end
      # after the last node has been found add a pointer to the new node to it 
      current_node.next = new_node
    end
  end

  def prepend(value)
    if self.is_empty?
      @head = Node.new(value)
    else
      # add new node
      head_node = @head
      first_node = head_node.next
      new_node = Node.new(value)
      # link to first item in linked list
      new_node.next = first_node
      # link head node to new node
      head_node.next = new_node
    end
  end

  def size
    if self.is_empty?
      return 0
    else
      current_node = @head
      counter = 0
      until current_node.next == nil
        current_node = current_node.next
        counter += 1
      end
    end
    counter + 1
  end

  def head
    if self.is_empty?
      return "There is no head - the list is empty"
    else
      return @head.to_s
    end
  end

  def tail
    if self.is_empty?
      return "There is no tail - the list is empty"
    else
      current_node = @head
      until current_node.next == nil
        current_node = current_node.next
      end
      current_node.to_s
    end
  end

  def at(index)
    if self.is_empty?
      return "The list is empty"
    else
      counter = 0
      current_node = @head
      unless counter == index
        current_node = current_node.next
        counter += 1
      end
      current_node.to_s
    end
  end

  def pop
    if self.is_empty?
      return "The list is empty"
    else
      # get the size of the linked list
      list_size = self.size
      # change the second last node.next to nil
      current_node = @head
      until current_node.next.next == nil
        current_node = current_node.next
      end
      current_node.next = nil
    end
  end

  def contains?(value)
    if self.is_empty?
      return "The list is empty"
    else
      current_node = @head
      until current_node.next == nil
        if current_node.value == value then return true else current_node = current_node.next end
      end
      # check last node
      return true if current_node.value == value
      false
    end
  end

  def find(value)
    if self.is_empty?
      return "The list is empty"
    else
      current_node = @head
      index = 0
      until current_node.next == nil
        if current_node.value == value then return index else current_node = current_node.next end
        index += 1
      end
      # check last node
      return index if current_node.value == value
      nil
    end
  end

  def insert_at(value, index)
    if self.is_empty?
      return "The list is empty"
    else
      # find what is currently at the index
      counter = 0
      current_node = @head
      until counter == index - 1
        current_node = current_node.next
        counter += 1
      end
      # insert the new node
      new_node = Node.new(value)
      new_node.next = current_node.next
      current_node.next = new_node
    end
  end

  def remove_at(index)
    if self.is_empty?
      return "The list is empty"
    else
      # find the node before the index
      counter = 0
      current_node = @head
      until counter == index - 1
        current_node = current_node.next
        counter += 1
      end
      current_node.next = current_node.next.next
    end
  end

  def to_s
    if self.is_empty?
      return "The list is empty"
    else
      # add each item into an array
      list = []
      current_node = @head
      until current_node.next == nil
        list.push("( #{current_node.value} )")
        current_node = current_node.next
      end
      # add the last node value
      list.push("( #{current_node.value} )")
      # join array into string 
      list.join(" -> ")
    end
  end
end

class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end

  def to_s
    "Node with value: #{@value}"
  end
end

list = LinkedList.new
list.append(50)
list.append(20)
list.prepend(1000000)
list.append(1)
p list.to_s
list.remove_at(3)
p list.to_s
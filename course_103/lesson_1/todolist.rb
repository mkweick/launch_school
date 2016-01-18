class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
    @nodos = ["test"]
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo
    @todos << todo
  end
  alias_method :add, :<<
  
  def all_done
    select { |todo| todo.done? }
  end
  
  def all_not_done
    select { |todo| !todo.done? }
  end
  
  def done?
    @todos.all? { |todo| todo.done? }
  end
  
  def done!
    @todos.each { |todo| todo.done! }
  end
  
  def each
    count = 0
    while count < @todos.size
      yield(@todos[count]) if block_given?
      count += 1
    end
    self
  end
  
  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end
  
  def first
    @todos.first
  end
  
  def item_at(index)
    @todos.fetch(index)
  end
  
  def last
    @todos.last
  end
  
  def mark_all_done
    each { |todo| todo.done! }
  end
  
  def mark_all_undone
    each { |todo| todo.undone! }
  end
  
  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end
  
  def mark_done_at(index)
    item_at(index).done!
  end
  
  def mark_undone_at(index)
    item_at(index).undone!
  end
  
  def pop
    @todos.pop
  end
  
  def remove_at(index)
    @todos.delete(item_at(index))
  end
  
  def select
    list = TodoList.new(title)
    count = 0
    while count < @todos.size
      todo = @todos[count]
      list.add(todo) if yield(todo)
      count += 1
    end
    list
  end
  
  def shift
    @todos.shift
  end
  
  def size
    @todos.size
  end
  
  def to_a
    @todos
  end
  
  def to_s
    @todos.map{|todo| "#{todo}"}.insert(0, "---- Today's Todos ----").join("\n")
  end
end




#todo1 = Todo.new("Buy milk")
#todo2 = Todo.new("Clean room")
#todo3 = Todo.new("Go to gym")
#list = TodoList.new("Today's Todos")
#
#list.add(todo1)                 # adds todo1 to end of list, returns list
#list.add(todo2)                 # adds todo2 to end of list, returns list
#list.add(todo3)                 # adds todo3 to end of list, returns list
#list.add(1)                     # raises TypeError with message "Can only add Todo objects"
#
#list.size                       # returns 3
#list.first                      # returns todo1, which is the first item in the list
#list.last                       # returns todo3, which is the last item in the list
#
#list.item_at                    # raises ArgumentError
#list.item_at(1)                 # returns 2nd item in list (zero based index)
#list.item_at(100)               # raises IndexError
#
#list.mark_done_at               # raises ArgumentError
#list.mark_done_at(1)            # marks the 2nd item as done
#list.mark_done_at(100)          # raises IndexError
#
#list.mark_undone_at             # raises ArgumentError
#list.mark_undone_at(1)          # marks the 2nd item as not done,
#list.mark_undone_at(100)        # raises IndexError
#
#list.shift                      # removes and returns the first item in list
#list.pop                        # removes and returns the last item in list
#
#list.remove_at                  # raises ArgumentError
#list.remove_at(0)               # removes and returns the 2nd item
#list.remove_at(100)             # raises IndexError
#
#list.each { |todo| todo.done! }
#list.to_s
#
#list.mark_undone_at(1)
#list.to_s
#puts
#
#list.select { |todo| !todo.done? }.each { |todo| puts todo }
#puts
#list.select { |todo| todo.done? }.each { |todo| puts todo }
#
#list.find_by_title("Buy milk")#
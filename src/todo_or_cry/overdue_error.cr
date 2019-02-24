module TodoOrCry
  # Error raised by `TodoOrCry.check` when a todo is past its due date.
  class OverdueError < Exception
  end
end

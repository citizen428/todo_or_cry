require "callstack"
require "./todo_or_cry/overdue_error"

CallStack.skip(__FILE__)

# Todo items you can't ignore.
# ```
# TodoOrDie["fix this", Time.utc(2019, 1, 1)]
#
# def broken_method; end
# # => raises TodoOrCry::OverdueError
# ```
# The error message can be configured with `.error_message=` and reset with
# `.default_error_message!`
module TodoOrCry
  VERSION       = "0.1.0"
  ERROR_MESSAGE = "TODO: \"%s\" came due on %s. Do it!"

  @@error_message : (String | Nil) = nil

  # :nodoc:
  def self.error_message
    @@error_message || ERROR_MESSAGE
  end

  # Sets a custom error message which needs to be a format string with two
  # string placeholders, the first for the todo comment, the second for the due
  # date.
  # ```
  # TodoOrCry.error_message = "You have failed to do \"%s\" since %s"
  # ```
  def self.error_message=(message)
    @@error_message = message
  end

  # Resets the custom error message so `ERROR_MESSAGE` will be used instead.
  def self.default_error_message!
    @@error_message = nil
  end

  # Main inferface. Raises a `TodoOrCry::OverdueError` if a todo is past its due
  # date.
  def self.[](message, due_date)
    return if Time.now < due_date
    exception = sprintf(error_message, message, due_date.to_s("%Y-%m-%d"))
    raise OverdueError.new(exception)
  end
end

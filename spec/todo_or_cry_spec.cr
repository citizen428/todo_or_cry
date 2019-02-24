require "./spec_helper"

describe TodoOrCry do
  it "doesn't raise an exception before the due date" do
    TodoOrCry["fix stuff", Time.now + 1.day]
  end

  it "raises an exception after the due date" do
    expected_message =
      sprintf(TodoOrCry::ERROR_MESSAGE, "fix stuff", yesterday.to_s("%Y-%m-%d"))

    expect_raises(TodoOrCry::OverdueError, expected_message) do
      TodoOrCry["fix stuff", yesterday]
    end
  end

  it "allows to set and reset the exception message" do
    expected_message1 =
      "You have failed to do \"fix stuff\" since #{yesterday.to_s("%Y-%m-%d")}"

    TodoOrCry.error_message = "You have failed to do \"%s\" since %s"
    expect_raises(TodoOrCry::OverdueError, expected_message1) do
      TodoOrCry["fix stuff", yesterday]
    end

    expected_message2 =
      sprintf(TodoOrCry::ERROR_MESSAGE, "fix stuff", yesterday.to_s("%Y-%m-%d"))

    TodoOrCry.default_error_message!
    expect_raises(TodoOrCry::OverdueError, expected_message2) do
      TodoOrCry["fix stuff", yesterday]
    end
  end
end

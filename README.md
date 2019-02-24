# TODO Or Cry!

Crystal implementation of the [TODO Or Die!](https://github.com/searls/todo_or_die) Ruby gem by Justin Searls.
Add TODOs in code that ensure you actually do them:

```crystal
TodoOrCry["fix this", Time.utc(2019, 1, 1)]
def broken_method; end
# => raises TodoOrCry::OverdueError
```

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     todo_or_cry:
       github: your-github-user/todo_or_cry
   ```

2. Run `shards install`

## Usage

Require `TodoOrCry` like this:

```crystal
require "todo_or_cry"
```

Then whenever you have a todo item you want to make sure gets done, add a call to `TodoOrCry.[]`:

```crystal
TodoOrCry["fix this", Time.utc(2019, 1, 1)]
```

Nothing will happen before the due date, but afterwards a `TodoOrCry::OverdueError` will be raised:

```
Unhandled exception: TODO: "fix this" came due on 2019-01-01. Do it! (TodoOrCry::OverdueError)
  from foo.cr:4:3 in '__crystal_main'
```

The error message can be customized with `.error_message=`:

```crystal
TodoOrCry.error_message = "You have failed to do \"%s\" since %s"

# Raises
Unhandled exception: You have failed to do "fix this" since 2019-01-01 (TodoOrCry::OverdueError)
  from foo.cr:4:3 in '__crystal_main'
```

To restore the standard error message, use `.default_error_message!`:

```crystal
TodoOrCry.default_error_message!
```

## Contributing

1. Fork it (<https://github.com/citizen428/todo_or_cry/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Michael Kohl](https://github.com/citizen428) - creator and maintainer

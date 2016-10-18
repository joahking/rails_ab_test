# RailsAbTest

Perform A/B Testing in your Rails app with ease.

The framework is a combination of

- minimal Code to support A/B Test versioning, is provided by this gem.
- A simple Pattern to organize the code in views into separated versions for each A/B Test version.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_ab_test'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_ab_test

## Usage

Let's start with the simplest usage case:

### The Code

Configure your ApplicationController by including the module:

```ruby
# application_controller.rb
include RailsAbTest::Controller
```

Then in the controller where an action (index in the example) will be A/B Tested,
set a `before_filter`:

```ruby
before_filter :choose_ab_test, only: :index
```

The method `choose_ab_test` will randomly (with 50% probability) choose A or B as the A/B Test version.
From here the version chosen will be accessible in the variable `@ab_test`.

Then inside the action you need to change `render` with `render_ab`

```ruby
def index
  render_ab
end
```

`render_ab` will infer the template to render from the action name, and prepend it with `@ab_test` to fully
determine the template name. e.g. if the A/B Version is A it will render the template `index_A`.

### The Pattern

Now you need to make 2 copies of your index view template, and name it `index_A` for the A/B Test version A, and
`index_B` for B.

And you are good to go. Your controller index action is ready to be A/B Tested.

## More complex usage

TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joahking/rails_ab_test.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

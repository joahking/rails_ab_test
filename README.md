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

Configure your controllers by including the module, normally ApplicationController is a good candidate for this:

```ruby
include RailsAbTest::Controller
```

Then for the action (index in the example) that  will be A/B Tested set a `before_filter`:

```ruby
before_filter :choose_ab_test, only: :index
```

The method `choose_ab_test` will randomly (with 50% probability) choose A or B as the A/B Test version.
From here the version chosen will be accessible in the variable `@ab_test`.

Then inside the action you need to replace `render` with `render_ab`

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

Make sure you set up different tracking for each version and you are good to go. Your controller index action is ready to be A/B Tested.

## QA and Test support

For testing and QA purposes the A/B Test version can also be selected by appending `?ab_test=A` to the url of the page,
that will make sure the version A is selected.

## More complex usage

### More versions that just A and B

Then instead of a `before_filter` you can call the method `choose_ab_test` directly:

```ruby
def show
  choose_ab_test ['A', 'B', 'C'] # this action calls the method directly instead
end
```

Again the 3 versions will have the same probability of being chosen.

*NOTE:* in the current version the gem does not support having different probabilities for the versions.

### Versioned partials

If instead of a full page template only a partial is going to be A/B Tested, you can achieve like this:

```ruby
# index.haml.html template
= render_ab partial: 'menu', variable_for_the_partial: @variable
```

The pattern again here is to make 2 copies of the `_menu` partial and name them, i.e. `_menu_A` and `_menu_B`.

### Versioned html snippets and partials

Based on the variable `@ab_test` you can also make conditions in views and helpers:

```ruby
# index.haml.html template
- if @ab_test == 'A'
  version A is rendered
- else
  hello B

# a view helper
def helper_method_AB_versioned
  if @ab_test == 'A'
    'version A is rendered'
  else
    'Hello B'
  end
end
```

### Several pages sharing same version

Now imagine that 2 controllers (e.g. posts and authors) index actions are A/B versioned,
and that you want that when an user sees version A of `posts#index` she should also see version A of `authors#index`.
This can be easily achieved by overriding the method `choose_ab_test` in both controllers, and using a cookie:

```ruby
# posts controller
before_filter :choose_ab_test, only: :index

def choose_ab_test
  @ab_test = cookies['shared-version-posts-authors'] || super
  cookies['shared-version-posts-authors'] = @ab_test
end

# authors controller should have the same code as above
```

Of course you can extract the common code to a central place. Also name the cookie with a name that makes sense, and expire it, sign it or encrypt it as needed.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joahking/rails_ab_test.

## TODOs

- write tests

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

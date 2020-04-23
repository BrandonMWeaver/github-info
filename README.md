# Github::Info

This gem provides commands which are used to retrieve and output information from a github profile.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github-info'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github-info

## Usage

This CLI gem provides the following commands:
  help
  exit
  git: [profile]
    name
    contributions
    repos
    history: [repository_index]

A [profile] is the username of a github profile.
      e.g. BrandonMWeaver

A [repository_index] is identified by the number to the left-hand side of a repository as listed by the output of repos.
      e.g. 1

help -> Provides a list of available commands and their usage.
exit -> Exit the program.
git: [profile] -> Retrieves information from a github profile.
  name -> Outputs the name of the user if one is provided.
  contributions -> Outputs the contributions commited by the user within the last year.
  repos -> Outputs an indexed list of the user's repositories.
  history: [repository_index] -> Outputs a list of a repository's commit history.
  directory: [repository_index] -> Outputs a list of a repository's primary directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BrandonMWeaver/github-info.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

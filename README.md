# Duffy

This is a collection of reusable things I don't want to keep duplicating in tons of projects.

## Installation

Add this line to your application's Gemfile:
* This is a work in progress.  If someone decides to use this, you may want to lock your version number in your gemfile.

```ruby
gem 'duffy'
```

And then execute:

    $ bundle

## Usage

String Patches:
```ruby
    to_ssn
    to_numeric
    to_alpha
    to_alpha_numeric
    pretty_phone
    pretty_committer    # TODO: Setup gem configuration to load patterns
    space2nbsp
    nl2br
    gender_human
    smart_titlecase     # Note: Has config options. See lib/duffy.rb
```

Git Access:
This one is namespaced incase you use the 'git' gem.  I found it to be overkill for what I wanted.
```ruby
    Duffy::Git.log      # => Produce tab separated listing of current git log.
    Duffy::Git.count    # => Count of git commits in current branch
```

View Helpers:
This is a work in progress.  I'm going to try to put all my generic helpers here.
```ruby
    menu_tag
    excel_icon
    icon
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/duffy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

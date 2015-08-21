# Duffy

[![Code Climate](https://codeclimate.com/github/duffyjp/duffy/badges/gpa.svg)](https://codeclimate.com/github/duffyjp/duffy)
[![Test Coverage](https://codeclimate.com/github/duffyjp/duffy/badges/coverage.svg)](https://codeclimate.com/github/duffyjp/duffy/coverage)

This is a collection of reusable things I don't want to keep duplicating in tons of projects.

## Installation

Add this line to your application's Gemfile:
* This is a work in progress.  If someone decides to use this, you may want to lock your version number in your gemfile.

```ruby
gem 'duffy'
```

And then execute:
```shell
$ bundle
```

## Usage

String Patches:

Method            | Example         | Output
------------------|-----------------|-------
md5               | "duffy"         | "904bc6e21e4799ce276200117215b88b"
md5sum            | "duffy"         | "904bc6e21e4799ce276200117215b88b"
to_ssn            | "123456789"     | "123-45-6789"
to_numeric        | "abc123"        | "123"
to_alpha          | "abc123"        | "abc"
to_alpha_numeric  | "abc#$%123"     | "abc123
pretty_phone      | "1234567890"    | "(123) 456-7890" 
pretty_committer  | "bart"          | "Bartholomew Simpson" (See config)
space2nbsp        | "space out"     | "space&nbsp;out" (requires rails)
nl2br             | "space\nout"    | "space<br/>out"  (requires rails)
gender_human      | "F"             | "Female"
smart_titlecase   | "this and that" | "This and That" (Note: Has config options. See lib/duffy.rb)


Date Patches:

Method            | Example         | Output
------------------|-----------------|-------
fiscal_year       | Date.today      | 2015 (See config to set your organization's fiscal year start.)


NilClass Patches:

Method            | Example         | Output
------------------|-----------------|-------
to_date           | nil             | self (Exists so you can call .to_date on Date, String or nil


Active Record Aliases:

Alias             | Standard
------------------|---------
accepts           | accepts_nested_attributes_for
habtm             | has_and_belongs_to_many


Git Access:
This one is namespaced in case you use the 'git' gem.  I found it to be overkill for what I wanted.
```ruby
Duffy::Git.log      # => Produce tab separated listing of current git log.
Duffy::Git.count    # => Count of git commits in current branch
Duffy::Git.email    # => Local repo's git user.email or global if none.
Duffy::Git.branch   # => Current git branch.
```

CPU Detection:
Linux and Mac only for now, each method returns 1 on unsupported hosts.
Example results for my dual core i5 with hyperthreading.
```ruby
Duffy::System.cpus       # => 1
Duffy::System.cores      # => 2
Duffy::System.threads    # => 4
Duffy::System.sane_load  # => 3
```


View Helpers:
This is a work in progress.  I'm going to try to put all my generic helpers here.
```ruby
menu_tag
excel_icon
icon
```

CSS Reset & Print Styles: Very barebones CSS Reset / Sensible defaults and Print stylesheets.
```ruby
require duffy/reset
require duffy/print
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/duffy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

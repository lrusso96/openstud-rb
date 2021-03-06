# Openstud

[![Build Status](https://travis-ci.com/lrusso96/openstud-rb.svg?branch=master)](https://travis-ci.com/lrusso96/openstud-rb)
![License: GPL v3](https://img.shields.io/badge/License-MIT-blue.svg)

[![Maintainability](https://api.codeclimate.com/v1/badges/449ca48703ccd2488357/maintainability)](https://codeclimate.com/github/lrusso96/openstud-rb/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/449ca48703ccd2488357/test_coverage)](https://codeclimate.com/github/lrusso96/openstud-rb/test_coverage)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](https://www.rubydoc.info/github/lrusso96/openstud-rb/master)

A Ruby gem for [Openstud](https://github.com/LithiumSR/openstud_driver).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openstud-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openstud-rb

## Usage

```ruby
os = Openstud::Base.new student_id: id, password: pwd

os.login
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Functionalities

### Authentication

- [x] Login
- [ ] Security question and password recovery
- [ ] Passsword reset

### Profile

- [x] Student infos
- [ ] Certificates
- [ ] Photo and student card

### Classroom

- [ ] Classroom and timetable

### Exams

- [ ] Doable and done exams
- [ ] Active and available reservations
- [ ] Insert and delete reservations
- [ ] Pdf reservation
- [ ] Calendar events
- [ ] Course surveys (OPIS)

### Taxes

- [ ] Paid and unpaid taxes
- [ ] Current ISEE and ISEE history

### News

- [ ] News and newsletter events

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/lrusso96/openstud-rb).

Take a look at the [Java project](https://github.com/LithiumSR/openstud_driver) too.

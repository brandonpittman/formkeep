# Formkeep

Formkeep lets you access your Formkeep API data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'formkeep'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install formkeep

## Caveats

**You must have a ~/.formkeep.yaml file!**

It should look something like this:

~~~rb
form_name: api_endpoint_url_in_full
~~~

You can have as many form entries as you like. They don't necessarily need to be named exactly how they are named on formkeep.com

## Usage

~~~rb
formkeep unread FORM
~~~

## Contributing

1. Fork it ( https://github.com/[my-github-username]/formkeep/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

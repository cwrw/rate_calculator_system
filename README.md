# Rate Calculator System

A rate calculator system which accepts a csv file for market data and a loan value and calculates the best rates available in the following format:

```ruby
  Requested amount: £XXXX

  Rate: X.X%

  Monthly repayment: £XXXX.XX

  Total repayment: £XXXX.XX
```

## Usage
To calculat the rates available either run the following command:

$ ``ruby ./bin/rate_calculator_system your_file.csv loan_value``

or make the file executable by:

$ ``chmod +x ./bin/rate_calculator_system``

and then run the calculator using:

$ ``./bin/rate_calculator_system your_file.csv loan_value``

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cwrw/rate_calculator_system. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The system is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Futurama Quotes

Get and create futurama quotes

This exposes a simple JSON API for accessing Futurama quotes. It's also possible to add your own quotes. 

It exposes these endpoints:

* GET /quote/:id # => Return specific quote
* GET /quote/random # => Return random quote
* GET /quote/regex/:regex # => Return first match. Regular expression should omit enclosing slashes and should be URL encoded
* GET /quote/by/:person # => Return all quotes for the person
* POST /quote # => Add a new quote to the list

And will return the quotes in this format:

```json
{
  "id": 1,
  "person": "Professor",
  "text": "Professor: I knew I should have shown him \"Electro-Gonnorhea, the Noisy Killer.\"",
  "created_at": "2015-12-03T22:44:09.200Z",
  "updated_at": "2015-12-03T22:44:09.200Z"
}
```

## Requirements

* Sqlite3
* Ruby 2.3

## Setup

```bash
./bin/setup
```

## Running a local server

```bash
bundle exec rackup
```

## Testing

```bash
bundle exec rspec
```

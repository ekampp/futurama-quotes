require_relative './../environment'

# Fetch initial quotes
response = Faraday.get 'https://raw.githubusercontent.com/WillsonSmith/polymer-futurama-quotes/master/futurama.js'
JSON.parse(response.body).each do |quote|
  person = quote.scan(/(\w+)(?:\:)/).flatten.first # Person: Something funny
  person ||= quote.scan(/(?:-)(\w+)/).flatten.last # Something funny -Person
  Futurama::Quote.create! \
    person: person.to_s.titleize,
    text: quote
end

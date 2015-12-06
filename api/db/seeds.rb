require_relative './../environment'

# Fetch initial quotes
response = Faraday.get 'https://raw.githubusercontent.com/WillsonSmith/polymer-futurama-quotes/master/futurama.js'
JSON.parse(response.body).each do |quote|

  # Grab quote inside ”” marks.
  text = quote.scan(/“([^”]+)|:(.+)/).flatten.first

  # Authors can e annotated either as "Author: Quote" or "Quote - Author"
  person = quote.scan(/(.+):|-{1,}(.+)/).flatten.map { |p| p.to_s.strip.presence }.compact.first

  # If It's "Author: Quote", then remove the "Author:" part, to unify display.
  text ||= quote.gsub("#{person}:", '')

  Futurama::Quote.create! \
    person: person.to_s.titleize,
    text: text.gsub("\n", '<br>')
end

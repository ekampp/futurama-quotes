module Futurama
  class Quotes < Grape::API
    format :json

    # Exception handling
    rescue_from ActiveRecord::RecordNotFound do
      error! 'No such quote', 404
    end

    namespace :quote do
      # GET /quote/random # => giver tilfældig fra listen
      desc 'Return a random quote'
      get :random do
        Quote.all.sample
      end

      # GET /quote/:id # => giver citat fra listen
      desc 'Return a specific quote'
      params do
        requires :id, type: Integer, desc: 'Index of specific quote'
      end
      route_param :id do
        get do
          Quote.find params.id
        end
      end

      # POST /quote # => tilføj nyt citat til listen
      desc 'Create a new quote'
      params do
        requires :text, type: String, desc: 'Quote. E.g. Something funny'
        requires :person, type: String, desc: "Who's quote is it. E.g. Edie Murphy"
      end
      post do
        Quote.create! params
      end

      namespace :regex do
        # GET /quote/regex/:regex # => finder den første som matcher ‘regex’
        desc 'Search for a quote matching a regular expression'
        params do
          # See http://meyerweb.com/eric/tools/dencoder for url en-/decode
          requires :regex, type: String, desc: 'URL encoded regular expression. Omit enclosing slashes.'
        end
        route_param :regex do
          get do
            Quote.where('text REGEXP ?', URI.unescape(params.regex)).take
          end
        end
      end

      namespace :by do
        # GET /quote/by/:person # => giver alle, som bliver sagt af person, f.eks. Fry
        desc 'Returns all quotes by given person.'
        params do
          requires :person, type: String, desc: "Who's quote is it. E.g.: Professor"
        end
        route_param :person do
          get do
            Quote.where(person: params.person.titleize)
          end
        end
      end
    end
  end
end

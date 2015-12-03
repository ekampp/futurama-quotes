require "spec_helper"

module Futurama
  RSpec.describe "/quote" do
    before(:all) { Timecop.freeze(Time.new(2015, 1, 1, 10)) }
    after(:all) { Timecop.return }
    let!(:quote) { create :quote }

    describe 'POST /' do
      let(:atrs) do
        {
          person: 'luke skywalker',
          text: "I'm not your son"
        }
      end

      it 'responds with the new quote' do
        post "/quote", atrs
        expect(parsed_response[:text]).to eql("I'm not your son")
        expect(parsed_response[:person]).to eql("Luke Skywalker")
      end

      it 'persists the new quote' do
        expect { post "/quote", atrs }.to change(Quote, :count).by(1)
      end
    end

    describe 'GET /:id' do
      it 'responds with the right quote' do
        get "/quote/#{quote.id}"
        expect(parsed_response).to eql({
          id: quote.id,
          person: "Edide Murphy",
          text: "Something funny",
          created_at: "2015-01-01T09:00:00.000Z",
          updated_at: "2015-01-01T09:00:00.000Z",
        })
      end
    end

    describe 'GET /random' do
      before { create_list :quote, 10 }

      it 'responds with a random quote' do
        ids = []
        10.times do
          get '/quote/random'
          ids << parsed_response[:id]
        end
        expect(ids.uniq.size).to be >= 2
        expect(parsed_response[:person]).to be_present
        expect(parsed_response[:text]).to be_present
        expect(parsed_response[:created_at]).to be_present
        expect(parsed_response[:updated_at]).to be_present
      end
    end

    describe 'GET /regex/:regex' do
      let!(:q1) { create :quote, text: 'aaaa' }
      let!(:q2) { create :quote, text: 'aabb' }
      let!(:q3) { create :quote, text: 'bbcc' }

      it 'correctly returns first match' do
        get '/quote/regex/bb'
        expect(parsed_response[:text]).to eql('aabb')
      end

      it 'correctly handles a more complex regex' do
        get '/quote/regex/%5Bc%5D%2B' # => [c]+
        expect(parsed_response[:text]).to eql('bbcc')
      end
    end

    describe 'GET /by/:person' do
      let!(:q1) { create :quote, text: 'aaaa', person: 'Donald Duck' }
      let!(:q2) { create :quote, text: 'aabb', person: 'Goofey' }
      let!(:q3) { create :quote, text: 'bbcc', person: 'Goofey' }

      it 'correctly returns all quotes for person' do
        get '/quote/by/goofey'
        expect(parsed_response).to eql([
          {
            id: q2.id,
            person: "Goofey",
            text: "aabb",
            created_at: "2015-01-01T09:00:00.000Z",
            updated_at: "2015-01-01T09:00:00.000Z",
          },
          {
            id: q3.id,
            person: "Goofey",
            text: "bbcc",
            created_at: "2015-01-01T09:00:00.000Z",
            updated_at: "2015-01-01T09:00:00.000Z",
          },
        ])
      end
    end
  end
end

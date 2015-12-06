require "spec_helper"

module Futurama
  RSpec.describe Quote do
    let(:atrs) do
      {
        text: 'Something funny',
        person: 'eddie murphy'
      }
    end
    let(:quote) { Quote.new(atrs) }

    it { should allow_mass_assignment_of(:text) }
    it { should allow_mass_assignment_of(:person) }
    it { is_expected.to validate_presence_of :text }

    it 'humanizes the person' do
      quote.save
      expect(Quote.last.person).to eql('Eddie Murphy')
    end
  end
end

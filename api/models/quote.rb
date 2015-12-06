module Futurama
  class Quote < ActiveRecord::Base
    attr_accessible :person, :text

    validates :text, presence: true

    def person=(value)
      write_attribute :person, value.titleize
    end
  end
end

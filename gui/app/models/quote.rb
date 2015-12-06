class Quote
  include Her::Model
  collection_path "/quote"
  custom_get :random

  attr_accessor :person, :text
end

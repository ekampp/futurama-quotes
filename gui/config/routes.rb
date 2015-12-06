Rails.application.routes.draw do
  get ':id', to: 'quotes#show', as: :show
  get 'regex/:regex', to: 'quotes#show', as: :search
  get 'by/:person', to: 'quotes#by', as: :by
  root to: 'quotes#random'
end

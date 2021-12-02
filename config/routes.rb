Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/exchange/convert', to: 'exchange#convert'
  get '/exchange/currency_codes', to: 'exchange#currency_codes'
end

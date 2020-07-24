Rails.application.routes.draw do
  #get 'users/song'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#hello'
  get '/users/:id/song', to: 'users#song'
end

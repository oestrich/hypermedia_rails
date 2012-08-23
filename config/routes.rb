Hypermedia::Application.routes.draw do
  devise_for :users

  resources :orders

  match "/docs" => Raddocs::App, :anchor => false

  root :to => "home#index"
end

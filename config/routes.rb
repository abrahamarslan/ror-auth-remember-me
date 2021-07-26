Rails.application.routes.draw do
  root 'home#home'
  #Home
  get "home"          => "home#home"
  get "about"         => "home#about"
  get "contact"       => "home#contact"
  #Authentication
  get "login"         => "authentication#login"
  post "login"        => "authentication#postLogin"
  get "signup"        => "authentication#signup"
  post "signup"       => "authentication#postSignup"
  get "logout"        => "authentication#logout"
  #User
  resources :user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

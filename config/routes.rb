Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"
    get "/search", to: "static_pages#search"
    post "/add_cart", to: "carts#add_to_cart"
    get "/cart", to: "carts#show"
    delete "/cart", to: "carts#destroy"
    patch "/cart", to: "carts#update"

    namespace :admin do
      resources :users
      resources :categories
      resources :products
      resources :orders, only: %i(index edit update)
      resources :order_details, only: :show
    end
    resources :orders, except: %i(edit update show)
    resources :users, only: %i(new create edit update)
    resources :products, only: %i(show index)
    resources :categories, only: %i(show index)
    devise_for :users, :path => "", :path_names => {:sign_in => "login", :sign_out => "logout", :edit => "profile", :confirmation => "confirmations"}, skip: :omniauth_callbacks
  end
end

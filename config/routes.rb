Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    post "/add_cart", to: "carts#add_to_cart"
    get "/cart", to: "carts#show"
    delete "/cart", to: "carts#destroy"
    patch "/cart", to: "carts#update"

    resources :users, only: %i(new create)
    resources :products, only: %i(show index)
    resources :categories, only: %i(show index)
  end
end

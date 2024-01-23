Rails.application.routes.draw do
  devise_for :users

  # Root route based on user's role_id
  get '/pre_index_path_buyer' => 'category#pre_buyer'
  get '/pre_index_path_seller' => 'category#pre_seller'

  get 'category/show', to: 'category#show', as: 'category_show'
  get 'category/new_product', to: 'category#new_product', as: 'category_new_product'
  post 'category/create_product', to: 'category#create_product', as: 'category_create_product'

  get 'category/pre_seller', to: 'category#pre_seller', as: 'category_pre_seller'
  root 'category#index'
  get '/search', to: 'category#search', as: 'search'

  get '/cart', to: 'category#cart_show', as: 'cart'

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'   
  end

  resources :categories do
  member do
    get 'purchase_product', to: 'category#purchase_product'
    post 'add_to_cart_product', to: 'category#add_to_cart_product'
  end
end

end


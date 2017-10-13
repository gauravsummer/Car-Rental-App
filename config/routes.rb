Rails.application.routes.draw do

  root 'car_rental#home'
  get 'sessions/new'
  get 'users/new'
  get '/help', to: 'car_rental#help'
  get '/about', to:'car_rental#about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get  '/new_user',  to: 'users#newuser'
  post '/new_user',  to: 'users#createuser'

  get  '/new_admin',  to: 'users#newadmin'
  get  '/edit',  to: 'users#edit'
  post '/new_admin',  to: 'users#createadmin'

  get  '/new_superadmin',  to: 'users#newsuperadmin'
  post '/new_superadmin',  to: 'users#createsuperadmin'


  get  '/cars',  to: 'cars#index'
  post '/cars',  to: 'cars#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'show_admin', to: 'users#show_admin', as: :show_admin, via: :all
  match '/users/newadmin', to: 'users#newadmin', as: :newadmin, via: :all

  get 'show_superadmin', to: 'users#show_superadmin', as: :show_superadmin, via: :all
  match '/users/newsuperadmin', to: 'users#newsuperadmin', as: :newsuperadmin, via: :all

  get '/bookings/:id/check_out', to: 'bookings#check_out', as: :check_out
  get '/bookings/:id/return', to: 'bookings#return', as: :return

  get 'email_notification/:id/:id1' => 'cars#email_notification' ,:as => 'email_notification'

  #match '/users/newuser', to: 'users#newuser', as: :new_user, via: :all
  resources :bookings
  #resources :users

  resources :users do
    resources :bookings
  end


  resources :cars do
    resources :bookings
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'users#index'
end

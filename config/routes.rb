Rails.application.routes.draw do 

  root to: "home#index" 

  resources :screens  
  resources :reviews 
  resources :shows
  resources :theaters 
  resources :booking_infos
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  get '/edit/password', to: 'home#edit_password', as: 'edit_password'
  match 'reset_password', via: [:get, :post], to: 'home#reset_password'

  post '/set_theater', to: 'application#set_theater'
 
  get '/theater_screens', to: 'booking_infos#theater_screens'
  get '/screens_shows', to: 'booking_infos#screens_shows'
  get '/shows_booking_dates', to: 'booking_infos#shows_booking_dates'
  get '/booking_dates_times', to: 'booking_infos#booking_dates_times'  
  get '/screen_slots', to: 'shows#screen_slots' 
  
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
end

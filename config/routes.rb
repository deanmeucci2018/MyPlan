Rails.application.routes.draw do

  #get 'student_interests/index'

  #get 'course_requirements/index'

  resources :requirements
  resources :interests
  resources :sections
  resources :courses
  resources :departments
  resources :users
  resources :enrolls
  resources :course_requirements
  resources :student_interests
  
  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get 'users/new'
  get   '/signup', to:   'users#new'

  get 'users/:id/enrollment', to: 'users#enrollment'
  get 'users/:id/interested', to: 'users#interested'
  
  get 'static_pages/help'

  get 'static_pages/about'

  get 'static_pages/contact'
  #homepage
  root'static_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

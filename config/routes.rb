Rails.application.routes.draw do
  get 'static_pages/help'

  get 'static_pages/about'

  get 'static_pages/contact'
  #homepage
  root'static_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

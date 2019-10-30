Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions', 
                                    registrations: 'users/registrations', 
                                    passwords: 'users/passwords' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles do
    resources :comments
  end
  
  root 'articles#index'
end

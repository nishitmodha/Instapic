Rails.application.routes.draw do
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications', to: 'notifications#index'

  get 'profiles/show'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :posts do
    resources :comments
      member do
        get 'like'
        get 'unlike'
      end
  end

  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

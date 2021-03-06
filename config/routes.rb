Rails.application.routes.draw do
  devise_for :staffs, path: "staffs", skip: [
    :registrations,
    :passwords
  ], controllers: {
    sessions: 'admin/staffs/sessions'
  }

  namespace :admin do
    root "products#index"
    resources :staffs
    resources :products do
      resources :images, only: [:create, :destroy]
      member do
        get :edit_image
      end
    end
  end

  root "products#index"
  resources :products, only: :index

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

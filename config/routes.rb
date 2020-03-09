Rails.application.routes.draw do
  devise_for :staffs, path: "staffs", controllers: {
    sessions: 'admin/staffs/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

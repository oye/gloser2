Rails.application.routes.draw do
  resources :assignments, only: [ :index, :new, :create ] do
      get :add_word, on: :member
      get :add_word, on: :collection, as: :add_word_new
  end

  get "assignments/:private_task_code/summary", to: "assignments#summary", as: "assignment_summary"
  get "assignments/:private_task_code/edit", to: "assignments#edit", as: "edit_assignment"
  patch "assignments/:private_task_code", to: "assignments#update", as: "update_assignment"
  delete "assignments/:private_task_code", to: "assignments#destroy", as: "destroy_assignment"
  get "assignments/:private_task_code/add_word", to: "assignments#new_word", as: "add_word_using_code"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "welcome#index"
end

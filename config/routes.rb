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
  get "assignments/:public_task_code/new_run", to: "assignments#new_run", as: "new_run"
  post "assignments/:public_task_code/new_run", to: "assignments#create_run", as: "create_run"
  get "assignments/:public_task_code/level_one", to: "assignments#level_one", as: "level_one"
  post "assignments/:public_task_code/level_one", to: "assignments#level_one_answer", as: "level_one_answer"
  get "assignments/:public_task_code/level_others", to: "assignments#level_others", as: "level_others"
  post "assignments/:public_task_code/level_others", to: "assignments#level_others_answer", as: "level_others_answer"
  get "assignments/:public_task_code/next_step", to: "assignments#next_step", as: "next_step"
  get "assignments/:public_task_code/completed", to: "assignments#completed", as: "completed"
  post "assignments/new_run_from_welcome", to: "assignments#new_run_from_welcome", as: "new_run_from_welcome"


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

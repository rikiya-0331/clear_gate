Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resource :mypage, only: [:show]
  resources :quiz_histories, only: [:show]
  resources :quizzes, path: 'quiz', only: [:show] do
    collection do
      get :start
      post :start, to: 'quizzes#create'
      get :results
    end
    member do
      post :answer
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  resources :questions, only: [:index, :show] do
    member do
      get :audio
    end
    collection do # Add this block
      get :autocomplete
    end
    resource :favorites, only: [:create, :destroy]
  end
end

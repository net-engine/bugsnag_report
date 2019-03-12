Rails.application.routes.draw do
  root to: 'accounts#new'
  resources :accounts, only: %i[create] do
    resources :organizations, only: %[index] do
      resources :projects, only: %i[index show]
    end
  end
end

Aronoff::Application.routes.draw do

  resources :immune_responses do
    member do
      get 's3_download'
    end
  end

  resources :macrophages do
    member do
      get 's3_download'
    end
  end

  resources :subscriptions

  resources :groups do
  	# Route for notifying and re-invite
		member do
			put 'notify'
		end
	end

  resources :projects

  devise_for :users

  scope :admin do
  	resources :users do

  	  # Account is an embedded document for a user with limited actions
  	  resources :accounts, only: [:new, :create, :edit, :update, :destroy]

  	end # users
	end

  # Search controller routes
  get   "search/bacteria"
  post  "search/by_bacteria"
  get   "search/free_form"
  post  "search/by_free_form"
  get   "search/tags"
  post  "search/by_tags"

  # Home controller routes
  get   "home/index"
  get   "home/support"
  get   "home/contact"
  post  "home/create_contact"
  get   "home/about"
  get   "admin/help"
  get   "admin/index"
  get   "admin/oops"
  get   "admin/calendar"

  get "admin" => 'admin#index'

  root :to => 'home#index'
end

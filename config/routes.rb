Rails.application.routes.draw do

  match 'users/admin', to: 'users#admin', via: :all
  match 'topics/:id/upvote', to: 'topics#upvote', via: :get, as: 'upvote_topic'
  resources :topics do
    resources :comments
  end
  resources :users

  # google api path
  get "auth/:provider/callback" => 'sessions#create'
  get 'auth/failure' => redirect('/')

  root :to => redirect('/topics')

  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete

  match '/topics_search', to: 'topics#search_topic', via: :post

  # TODO CheckBox Option
  # match 'topic/delete_topic'
  # resources :topics do
  #   collection do
  #     delete 'delete_topic'
  #   end
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

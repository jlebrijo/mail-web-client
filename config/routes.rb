MailWebClient::Application.routes.draw do
  resources :folders do
    resources :active_imap_messages
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
end

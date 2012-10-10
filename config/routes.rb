MailWebClient::Application.routes.draw do
  resources :active_imap_messages
  match 'active_imap_messages/folder/:folder_id' => 'active_imap_messages#index', :as => :change_folder

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
end

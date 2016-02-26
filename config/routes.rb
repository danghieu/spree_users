Spree::Core::Engine.routes.draw do
  
  # Add your extension routes here
   
  
  
  namespace :api do

    resources :products do
      resources :comments
    end

    resources :comments

    resources :users 

  	post "/login" => "/spree/api/log_user#login"
  	post "/logout" => "/spree/api/log_user#logout"
  	put "/users/:id/change_password" => "/spree/api/users#change_password"
  	post "/check" => "/spree/api/log_user#check"
  	post "/forgot_password" => "/spree/api/users#forgot_password"
  	put "/reset_password" => "/spree/api/users#reset_password"
  	
    post "/likes" => "/spree/api/likes#create"
    delete "/likes" => "/spree/api/likes#destroy"

    get "edit_user" => "/spree/api/users#edit"
    put "update_user" => "/spree/api/users#update"

    

    
  end
end

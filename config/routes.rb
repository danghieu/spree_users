Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  post "/api/login" => "api/log_user#login"
  post "/api/logout" => "api/log_user#logout" 
end

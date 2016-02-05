module Spree
	module Api
	class LogUserController < Spree::Api::BaseController
		before_action :authenticate_user, :except => [:login]
      def login
        @user = Spree.user_class.find_for_database_authentication(:email => params[:email])
        p @user
        if  @user && @user.valid_password?(params[:password])
          sign_in(@user)

          # @order = find_cart_order_login(@user)
          # unless @order
          #   @order = Spree::Order.new_order(@user)
          # end

          @user.generate_spree_api_key!

          render "spree/api/users/show", status: 200
        else
          @status = [{ "messages" => "Your Email or Password is wrong"}]
          render "spree/api/logger/log", status: 404
        end
      end

      def logout
        @user = Spree.user_class.find_for_database_authentication(:spree_api_key => request.headers['X-Spree-Token'])
        if @user
          sign_out(@user)
          @user.generate_spree_api_key!
          # respond_to do |format|
          # 	format.json { render :json => { "message " =>  "Logout Successful" }}
          # end
          @status = [ { "messages" => "Logout successful"}]
          render "spree/api/logger/log", status: 200
        else
          @status = [ { "messages" => "API-Key isn't valuable"}]
          render "spree/api/logger/log", status: 404
        end
      end
	end
end
end
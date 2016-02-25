Spree::Api::UsersController.class_eval do
#include Spree::OrdersImporter
  before_action :authenticate_user, :except => [:create, :reset_password, :reset_new_password, :forgot_password]
  def create
    @user = Spree.user_class.new(user_params)
    if @user.save!
      sign_in(@user)
      #@order = find_cart_order_login(@user)
      #unless @order
      #@order = Spree::Order.new_order(user)
      #end
      @user.generate_spree_api_key!
      UserMailer.welcome_email(@user).deliver
      render "spree/api/users/show", status: 201
    else
      invalid_resource!(@user)
    end

  end

  def edit
    @user = current_api_user

    render "spree/api/users/edit", status: 200

  end

  def show
    # @user ||= Spree.user_class.accessible_by(current_ability, :read).find(params[:id])
    @user = user
    render  "spree/api/users/show_detail", status: 200
  end

  def update
    # @user = Spree::User.find(params[:id])
    @user = current_api_user 
    authorize! :update, @user

    if params[:password].present?

      if @user.change_password(password_params)
        @status = [ { "messages" => "Your password was successfully updated"}]
      else
        @status = [ { "messages" => "Your password was incorect"}]
      end

    elsif params[:user].present?

      if  @user.update(user_information_params)
        @status = [ { "messages" => "Your information was successfully updated"}]
      else
        @status = [ { "messages" => "Your information was not successfully updated"}]
      end

    end

    render "spree/api/logger/log"
      

    # @user.update(user_information_params)
    # @status = [ { "messages" => "Your information was successfully updated"}]

    # if params[:password].present?
    #     if @user.valid_password?(password_params[:old])
    #       @user.password = password_params[:new] 
    #       @user.save
    #       @status = [ { "messages" => "Your information was successfully updated"}]
    #     else
    #       @status = [ { "messages" => "Your password was incorect"}]
    #     end
    # end

    # render "spree/api/logger/log"

  end

  # def change_password
  #   @user = current_api_user
  #   authorize! :update, @user

  #   if @user.valid_password?(password_params[:old])
  #     @user.password = password_params[:new]
  #     @user.save
  #     p @user.password
  #     @status = [ { "messages" => "Update Password Successful"}]
  #     render "spree/api/logger/log", status: 200
  #   else
  #     @status = [ { "messages" => "Password Is Not Right"}]
  #     render "spree/api/logger/log", status: 404
  #   end
  # end

  def forgot_password
    @user = Spree::User.find_by!(email: params[:email])
    raw, enc = Devise.token_generator.generate(Spree::User, :reset_password_token)
    @user.reset_password_token = enc
    @user.reset_password_sent_at = Time.now.utc
    @user.save
    UserMailer.forgot_password_email(@user).deliver
    @status = [{"messages" => "Request Successful"}]
    render "spree/api/logger/log" , status: 200

  end

  def reset_password
    @user = Spree::User.find_by!(id: reset_password_params[:id], reset_password_token: reset_password_params[:token])
    @user.password = reset_password_params[:new_password]
    @user.reset_password_token = nil
    @user.save
    UserMailer.password_change_email(@user).deliver
    @status = [ { "messages" => "Reset Password Successful"}]
    render "spree/api/logger/log", status: 200  
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def user_information_params
    params.require(:user).permit(:first_name, :last_name, :birth_day, :email)
  end

  def password_params
    params.require(:password).permit(:old, :new)
  end

  def reset_password_params
    params.require(:password).permit(:id, :token, :new_password)
  end

end
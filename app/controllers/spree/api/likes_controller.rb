module Spree
  module Api
class LikesController < Spree::Api::BaseController
  
  before_action :authenticate_user

  # GET /likes
  # def index
  #   @likes = Like.all
  # end

  # GET /likes/1
  # def show
  # end

  # GET /likes/new
  # def new
  #   @like = Like.new
  # end

  # GET /likes/1/edit
  # def edit
  # end

  # POST /likes
  def create
    @like = Dish::Like.new(like_params)

    if @like.save
      @status = [ { "messages" => "Like was successfully created"}]
      
    else
      @status = [ { "messages" => "Like was not successfully created"}]
    end
    render "spree/api/logger/log", status: 200
  end

  # PATCH/PUT /likes/1
  # def update
  #   if @like.update(like_params)
  #     redirect_to @like, notice: 'Like was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # DELETE /likes/1
  def destroy
    @like = Dish::Like.find_by(like_params)
    if @like.destroy
      @status = [ { "messages" => "Like was successfully destroyed"}]
      
    else
      @status = [ { "messages" => "Like was not successfully destroyed"}]
    end
    render "spree/api/logger/log", status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_like
    #   @like = Like.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:user_id, :product_id)
    end
end
end
end

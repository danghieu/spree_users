module Spree
  	module Api
    	class CommentsController < Spree::Api::BaseController
        before_action :authenticate_user, :except => [:index, :show]
        before_action :current_user_id

    		def show
    			@comment = Dish::Comment.find(params[:id])
    			render "spree/api/comments/show", status: 200
    		end

    		def index
          if params[:product_id]
            @comments = Spree::Product.find(params[:product_id]).approved_comments
    			else 
            @comments = Dish::Comment.approved_comments
          end
    			render "spree/api/comments/index2", status: 200
    		end

    		def create
    			 @comment = Dish::Comment.new(comment_params.merge!(:product_id => params[:product_id],:user_id => current_user_id))
    			 if @comment.save
    				  @status = [ { "messages" => "Your comment was successfully created"}]
      		  else
        		@status = [ { "messages" => "Your comment was not successfully created"}]
      		  end
      		render "spree/api/comments/show"
    		end

    		def update
    			@comment = Dish::Comment.find(params[:id])
    			if @comment.update(comment_params)
    				@status = [ { "messages" => "Your comment was successfully updated"}]
      		else
        		@status = [ { "messages" => "Your comment was not successfully updated"}]
      		end
      		render "spree/api/logger/log"
    		end

    		def destroy
    			@comment = Dish::Comment.find(params[:id])
    			if @comment.move_to_trash
    				@status = [ { "messages" => "Your comment was successfully destroyed"}]
      		else
        		@status = [ { "messages" => "Your comment was not successfully destroyed"}]
      		end
      		render "spree/api/logger/log"
    		end

    		private

    		def comment_params
    			params.require(:comment).permit(:title, :body, :rating)
    		end

        # def comment_update_params
        #   params.require(:comment).permit(:title, :body, :rating)
        # end

        def current_user_id
          @current_user_id = request.headers["X-Spree-Token"].present? ? current_api_user.id : nil;
        end

    	end
	end
end
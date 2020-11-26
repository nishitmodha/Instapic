class CommentsController < ApplicationController
    before_action :set_post

    def create
      @comment = @post.comments.build(comment_params)
      @comment.user_id = current_user.id
        

      respond_to do |format|
        if @comment.save
            format.html { redirect_to root_path, notice: 'Comment created' }
            format.js
          else
            flash[:alert] = "Check the comment form, something went horribly wrong."
            render root_path
          end
      end
      
    end

    def destroy
        @comment = @post.comments.find(params[:id])
      
        @comment.destroy
        # flash[:success] = "Comment deleted :("
        # redirect_to root_path
        redirect_to root_path, notice: "Deleted"
    end
    
    private
    
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def set_post
      @post = Post.find(params[:post_id])
    end
end

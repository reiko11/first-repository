class CommentsController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!
    def create
        post = Post.find(params[:post_id])
        comment = post.comments.build(comment_params) #buildを使い、contentとpost_idの二つを同時に代入
        comment.user_id = current_user.id
        if comment.save
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path)
        else
            flash[:success] = "コメントできませんでした"
            redirect_back(fallback_location: root_path)
        end
    end
    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            redirect_to post_path(@post)
        else   
            render post_path(@post)
        end
    end
    private
        def set_post
            @post = Post.find(params[:post_id])
        end
        def comment_params
            params.require(:comment).permit(:content)
        end
end
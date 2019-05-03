class CommentsController < ApplicationController

    before_action :authenticate_user!

    # respond_to は
    # コメントを押したらリアルタイムでビューを反映させるために
    # フォーマットを切り替えるためのメソッド
    def create 
      @comment = Comment.new(comment_params)
      @post = @comment.post
      if @comment.save
        respond_to :js
      else 
        flash[:alert] = " コメントに失敗しました "
      end
    end

    def destroy
      @comment = Comment.find_by(id: params[:id])
      @post = @comment.post
      if @comment.destroy
        respond_to :js
      else
        flash[:alert] = "コメントの投稿を削除しました"
      end
    end

    private
      def comment_params 
        params.required(:comment).permit(:user_id, :post_id, :comment)
      end
    
end

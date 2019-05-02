class PostsController < ApplicationController

    # 下記はdeviseのデフォルトのメソッド
    # ユーザーがサインインしてない状態だと投稿ページで投稿しても誰が投稿したかわからない。
    # また投稿された画像はサインインしたユーザーのみ見えるようにする
    before_action :authenticate_user!

    def new
      @post = Post.new
      @post.photos.build
    end

    def create
      @post = Post.new(post_params)
      if @post.photos.present?
        redirect_to root_path
        flash[:notice] = "投稿が保存されました"
      else 
        redirect_to root_path
        flash[:alert] = "投稿に失敗しました"
      end
    end

    private

      def post_params
        params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
      end

end
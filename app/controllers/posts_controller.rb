class PostsController < ApplicationController

    # 下記はdeviseのデフォルトのメソッド
    # ユーザーがサインインしてない状態だと投稿ページで投稿しても誰が投稿したかわからない。
    # また投稿された画像はサインインしたユーザーのみ見えるようにする
    before_action :authenticate_user!
    before_action :set_post, only: %i(show destory)

    def new
      @post = Post.new
      @post.photos.build
    end

    def index
      @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
    end

    def create
      @post = Post.new(post_params)
      if @post.photos.present?
        @post.save
        redirect_to root_path
        flash[:notice] = "投稿が保存されました"
      else 
        # リダイレクト設定する
        redirect_to new_post_path
        flash[:alert] = "投稿に失敗しました"
      end
    end

    # 下記のコードでやっていることは受け取ったHTTPリクエストからidを判別し
    # 指定のレコードに1つを@postに代入します
    # @post に投稿の情報を入れることで, @postを使ってビューに投稿のキャプションを表示させることができます。
    def show
      @post = Post.find_by(id: params[:id]) 
    end

    def destroy
      @post = Post.find_by(id: params[:id])
      # 投稿したユーザーと現在サインインしているユーザーが等しければ、真を返す条件式です。
      # 下の三項演算子は このように書き換えられる
      # if @post.destory
      #   flash[:notice] = "投稿が削除されます"
      # end
      if @post.user == current_user
        flash[:notice] = "投稿が削除されました" if @post.destroy
      else
        flash[:notice] = "投稿の削除に失敗しました"
      end
      redirect_to root_path
    end


    private

      def post_params
        params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
      end

      def set_post
        @post = Post.find_by(id: params[:id])
      end

end

class PostsController < ApplicationController

    # 下記はdeviseのデフォルトのメソッド
    # ユーザーがサインインしてない状態だと投稿ページで投稿しても誰が投稿したかわからない。
    # また投稿された画像はサインインしたユーザーのみ見えるようにする
    before_action :authenticate_user!

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




    private
      def post_params
        params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
      end

end

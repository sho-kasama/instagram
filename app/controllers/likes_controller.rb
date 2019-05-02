class LikesController < ApplicationController

    # :authenticate_user!を使ってサインイン済みユーザーにのみにアクセス許可を与えるようにします
    before_action :authenticate_user!

    def create
      # このコードはbuildメソッドを使って、インスタンスを作成してる。またlike_paramsメソッドをメソッドを引数で呼び出してる
      @like = current_user.likes.build(like_params)
      @post = @like.post
      # respond_to は返却するレスポンスのフォーマットを切り替えるメソッドです。
      # 今回いいねを押したらリアルタイムでビューを反映させるためにフォーマットをJS形式でレスポンスを返すようにしてる
      if @like.save
        respond_to :js
      end
    end

    def destroy
      @like = Like.find_by(id: params[:id])
      @post = @like.post
      if @like.destroy
        respond_to :js
      end
    end


    private
      # paramsとは送られてきたリクエスト情報をひとまとめにしたもの
      # permitで変更を加えられるキーを指定する。いいねを押した時にどの投稿にいいねをしたかをpost_idの情報を変更できるように指定している。
      def like_params
        params.permit(:post_id)
      end
end

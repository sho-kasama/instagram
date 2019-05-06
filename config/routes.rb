Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations'}

  # pagesコントローラーのhomeアクションのルーティングをトップページのルーティングとして設定する
  root 'posts#index'
  
  
  # ここにusersコントローラーのshowアクションのルーティングを追加する
  # asオプションを使うとルーティングに名前をつけることができる
  get '/users/:id', to: 'users#show', as: 'user'

  # postsコントローラーのnewアクション,createアクション,photosコントローラーのcreate
  resources :posts, only: %i(new create index show destroy) do 
    resources :photos, only: %i(create)

    # ルーティングをネストにすることで親子関係を表すことができる
    resources :likes, only: %i(create destroy)

    # コメントの情報を削除と作成するルーティングを追加する
    resources :comments, only: %i(create destroy)

  end

end

# photoコントローラーが存在しない。ここで調べてみる

# 404/500エラーの処理を書いてる
#%w(get put patch post delete).each do |method|
 # send(method, '*something', controller: :application, action: :render_404)
#end
get '*not_found' => 'application#routing_error'
post '*not_found' => 'application#routing_error'
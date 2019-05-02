Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations'}

  # pagesコントローラーのhomeアクションのルーティングをトップページのルーティングとして設定する
  root 'pages#home'
  
  
  # ここにusersコントローラーのshowアクションのルーティングを追加する
  # asオプションを使うとルーティングに名前をつけることができる
  get '/users/:id', to: 'users#show', as: 'user'

  # postsコントローラーのnewアクション,createアクション,photosコントローラーのcreate
  resources :posts, only: %i(new create)do 
    resources :photos, only: %i(create)
  end

end

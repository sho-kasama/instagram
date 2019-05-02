Rails.application.routes.draw do
  devise_for :users
  # pagesコントローラーのhomeアクションのルーティングをトップページのルーティングとして設定する
  root 'pages#home'
  
  
  # ここにusersコントローラーのshowアクションのルーティングを追加する
  # asオプションを使うとルーティングに名前をつけることができる
  get '/users/:id', to: 'users#show', as: 'user'


end

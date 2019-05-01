Rails.application.routes.draw do
  devise_for :users
  # pagesコントローラーのhomeアクションのルーティングをトップページのルーティングとして設定する
  root 'pages#home'
end

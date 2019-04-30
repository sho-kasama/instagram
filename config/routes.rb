Rails.application.routes.draw do
  # pagesコントローラーのhomeアクションのルーティングをトップページのルーティングとして設定する
  root 'pages#home'
end

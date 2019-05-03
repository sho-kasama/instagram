class Photo < ApplicationRecord
    belongs_to :post
  
    validates :image, presence: true
  
    # ここを追加
    # mount_uploderの意味を調べる
    mount_uploader :image, ImageUploader
  end
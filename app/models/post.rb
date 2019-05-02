class Post < ApplicationRecord

    belongs_to :user
    has_many :photos, dependent: :destroy
    has_many :likes, dependent: :destroy

    # 親子関係のある関連モデル で、親から子を作成したり保存するときに使える
    accepts_nested_attributes_for :photos

    def liked_by(curret_user)
      Like.find_by(user_id: curret_user.id)
    end
end

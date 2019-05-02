class Post < ApplicationRecord

    belongs_to :user
    has_many :photos, dependent: :destroy

    # 親子関係のある関連モデル で、親から子を作成したり保存するときに使える
    accepts_nested_attributes_for :photos


end

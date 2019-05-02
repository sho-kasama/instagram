class Like < ApplicationRecord

    # has_manyが使用されている場合は、「反対側」のモデルでは多くの場合 belongs_to が使われてます
    belongs_to :user
    belongs_to :post
    validates :user_id, uniqueness: { scope: :post_id }
end

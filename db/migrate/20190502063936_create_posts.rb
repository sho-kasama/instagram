class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.string :caption
      # references型で保存すると、user_idを外部キーとして明示的に表示できます
      # 外部キーとは関連したテーブルの間を結ぶために設定する設定する例のことです。(今回はpostsテーブルと、usersテーブル)
      # foreign_key は外部キーとして使用するということを示しています。
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end

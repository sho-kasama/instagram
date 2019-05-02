class User < ApplicationRecord

  # has_manyは他のモデルとの間に「1対多」の繋がりがあることを示します。「1側」にhas_manyを使用します
  # has_manyの反対側はbelongs_toが使われます
  # dependent: :destoryをつけることでオブジェクトが削除されるときに関連付けられたオブジェクトの
  # destoryメソッドが実行される
  has_many :posts, dependent: :destroy



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :name, presence: true, length: { maximum: 50 }


  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, user: 1 }, default: :user

  has_many :cart_items, class_name: "CartItems", dependent: :destroy
  has_many :orders, class_name: "Order", dependent: :destroy
end

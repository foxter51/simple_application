# Represents User model
class User < ApplicationRecord
  has_many :posts
  has_many :comments

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :registerable, :recoverable, :rememberable,
         :validatable
end

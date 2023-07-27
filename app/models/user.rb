# Represents User model
class User < ApplicationRecord
  has_many :posts

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :registerable, :recoverable, :rememberable,
         :validatable
end

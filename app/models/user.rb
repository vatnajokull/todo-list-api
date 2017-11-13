class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  before_save :skip_confirmation!
  before_save :skip_confirmation_notification!

  has_many :projects, dependent: :destroy
end

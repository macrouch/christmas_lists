class User < ActiveRecord::Base
  has_many :lists, foreign_key: :owner

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
end

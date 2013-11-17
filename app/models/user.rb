class User < ActiveRecord::Base
  has_many :lists, foreign_key: :owner

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

  def self.from_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first || create_with_omniauth(auth)    
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
    end
  end
end

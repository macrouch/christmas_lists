class User < ActiveRecord::Base
  has_many :lists
  has_many :item_comments
  has_many :group_members
  has_many :groups, through: :group_members
  has_one :group

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

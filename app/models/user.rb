class User < ActiveRecord::Base
  has_many :lists
  has_many :item_comments
  has_many :group_members
  has_many :groups, through: :group_members
  has_one :group

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validates :email, presence: true, uniqueness: true

  obfuscate_id spin: 891561354

  def self.from_omniauth(auth, return_to=nil)
    where(email: auth['info']['email']).first || create_with_omniauth(auth, return_to)
  end

  def self.create_with_omniauth(auth, return_to)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.email = auth['info']['email']
      if auth['provider'] == "identity"
        user.original_url = return_to
        user.generate_token(:email_token)
      else
        user.active = true
      end
    end
    user = User.where(uid: auth[:uid]).first
    UserMailer.activation_email(user).deliver unless user.active
    user
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    self[column] = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(column => random_token)
    end
  end
end

class Identity < OmniAuth::Identity::Models::ActiveRecord
  # has_secure_password
  
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i }

  private

  def identity_params
    params.require(:identity).permit(:name, :email, :password, :password_confirmation)
  end
end

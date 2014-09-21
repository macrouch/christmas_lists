class Item < ActiveRecord::Base
  belongs_to :list
  has_many :item_comments

  validates :name, presence: true
  validates :list, presence: true
  # validates :hidden_from_owner, presence: true

  obfuscate_id spin: 546518432

  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    :default_url => '/images/no_image.png'

  def image_url=(url)
    self.image = URI.parse(url)
  end
end

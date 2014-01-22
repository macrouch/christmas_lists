class Item < ActiveRecord::Base
  belongs_to :list
  has_many :item_comments

  validates :name, presence: true
  validates :list, presence: true
  # validates :visible_to_owner, presence: true

  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    :default_url => '/assets/no_image.png'

  def image_url=(url)
    self.image = URI.parse(url)
  end
end

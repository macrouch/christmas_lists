require 'httparty'
require 'uri'

class Item < ActiveRecord::Base
  belongs_to :list
  has_many :item_comments

  validates :name, presence: true
  validates :list, presence: true
  validates :description, length: { maximum: 256 }
  # validates :hidden_from_owner, presence: true

  obfuscate_id spin: 546518432

  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    :default_url => '/images/no_image.png',
    :url => "/item_images/:id/:basename_:style.:extension"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  before_validation :shorten_urls

  def image_url=(url)
    self.image = URI.parse(url)
  end

  def shorten_urls
    unless description.nil?
      urls = URI.extract(description)
      urls.each do |url|
        result = HTTParty.get("https://api-ssl.bitly.com/v3/shorten?access_token=#{ENV['BITLY_TOKEN']}&longUrl=#{url}")
        short_url = result.fetch('data', {})['url']

        description.gsub!(url, short_url) unless short_url.nil?
      end
    end
  end
end

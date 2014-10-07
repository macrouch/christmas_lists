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
    :default_url => '/images/no_image.png'

  before_validation :shorten_urls

  def image_url=(url)
    self.image = URI.parse(url)
  end

  def shorten_urls
    unless description.nil?
      urls = URI.extract(description)
      urls.each do |url|
        result = HTTParty.post("https://www.googleapis.com/urlshortener/v1/url",
          query: { key: ENV['GOOGLE_SERVER_KEY'] },
          body: { longUrl: "#{url}" }.to_json,
          headers: {'Content-Type' => 'application/json'} )
        short_url = result['id']

        description.gsub!(url, short_url) unless short_url.nil?
      end
      # self.update(des)
    end
  end
end

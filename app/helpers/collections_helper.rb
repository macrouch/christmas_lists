module CollectionsHelper
  def auto_link_text(text)
    auto_link(text, :html => { :target => '_blank' }) do |url|
      truncate(url, :length => 33)
    end
  end
end

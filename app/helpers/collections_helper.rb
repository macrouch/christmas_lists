module CollectionsHelper
  def auto_link_text(text)
    auto_link(text) do |url|
      short_url(url)
    end
  end

  def short_url(url)
    if url.length > 30
      url[0..29] + '...'
    else
      url
    end
  end
end

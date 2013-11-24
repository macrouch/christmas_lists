module ListsHelper
  # Add icons before the edit link of the item
  # if the item is hidden from the owner or purchased
  def item_link(list, item)
    classes = []
    if current_user != list.user && item.hidden_from_owner
      classes << 'icon-exclamation-sign'
    end

    if current_user != list.user && item.purchased
      classes <<'icon-check'
    end

    html = ''
    classes.each do |c|
      html += "#{content_tag 'i', '', class: c}"
    end

    html += "#{link_to item.name, edit_list_item_path(list, item)}"

    raw(html)
  end

  # Convert a list name to html ID
  def name_to_id(name)
    name.downcase.gsub(' ', '_')
  end
end

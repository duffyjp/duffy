module DuffyHelper

  # This creates menu entries in the format Zurb Foundation expects.
  # It's just an <li> with a link inside it.
  # menu_tag('Help', help_path)   =>  <li><a href="/help">Help</a></li>
  def menu_tag(title, link, options = {})
    content_tag(:li, link_to(title, link), options)
  end

end

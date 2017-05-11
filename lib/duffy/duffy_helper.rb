module DuffyHelper

  # This creates menu entries in the format Zurb Foundation expects.
  # It's just an <li> with a link inside it.
  # menu_tag('Help', help_path)   =>  <li><a href="/help">Help</a></li>
  def menu_tag(title, link, options = {})
    ActiveSupport::Deprecation.warn('This method will be removed without replacement in future versions')
    content_tag(:li, link_to(title, link), options)
  end

end

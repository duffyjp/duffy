module DuffyHelper

  # This creates menu entries in the format Zurb Foundation expects.
  # It's just an <li> with a link inside it.
  # menu_tag('Help', help_path)   =>  <li><a href="/help">Help</a></li>
  def menu_tag(title, link, options = {})
    content_tag(:li, link_to(title, link), options)
  end

  # Create Excel icon in consistent location
  # This is intended to display the xlsx version of a view.
  # Add a yield(:excel) somewhere in your application layout:
  #   content_tag( :li, yield(:excel), class: :excel) if content_for?(:excel)
  def excel_icon(link = params.merge(format: "xlsx"))
    content_for :excel do
      link_to(image_tag('excel.png'), link)
    end
  end

  # Create a simple link with the class "icon"
  # Generate a uniq and reasonable id based on the link passed (if any)
  # Add any classes passed in via options
  # Add the "favorite" class if icon is favorited
  #  - This is application specific and will just not do anything if it runs into a problem
  # If any uncaught exceptions are thrown in production you'll just get nothing, otherwise you'll get the error on screen.
  def icon(title, link, options = {})
    begin
      options[:id]    = "icon_#{link.parameterize("_")}" unless link.blank?
      options[:class] = [:icon] << options[:class]
      options[:class] << :favorite if defined?(current_user) and (current_user.person.details.where(key: "favorite_#{options[:id]}").any? rescue false)
      options[:class] = options[:class].flatten.compact
      link_to(title, link, options)
    rescue Exception => e
      Rails.env.development? ? content_tag(:p, e) : nil
    end
  end

end

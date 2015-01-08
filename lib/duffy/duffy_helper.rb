module DuffyHelper

  def menu_tag( title, link, options = {})
    link_to(content_tag(:li, title, options), link)
  end

  def excel_icon(link = params.merge(:format => "xlsx"))
    # Create Excel icon in consistent location
    content_for :excel do
      link_to(image_tag('excel.png', :width => 40, :height => 40), link)
    end
  end

  def icon(title, link, options = {})
    begin
      options[:id]    = "icon_#{link.parameterize("_")}"
      options[:class] = [:icon] << options[:class]
      options[:class] << "favorite" if defined?(current_user) and (current_user.person.details.where(key: "favorite_#{options[:id]}").any? rescue false)
      link_to(title, link, options)
    rescue Exception => e
      Rails.env.development? ? content_tag(:p, e) : nil
    end
  end








end

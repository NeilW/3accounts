# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def classify_link_if_current(link_text, options = {}, html_options = {})
    html_options[:class] ||="current" if current_page?(options)
    link_to(link_text, options, html_options)
  end
end

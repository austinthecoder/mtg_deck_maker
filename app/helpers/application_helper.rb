module ApplicationHelper

  def submit_button(name, options = {})
    options.merge!(:type => 'submit')
    options[:class] = options[:class].to_s.split(' ').push('btn').uniq.join(' ')
    content_tag(:button, %(<span><span><b>&nbsp;</b><u>#{name}</u></span></span>).html_safe, options)
  end

  def button(name, options = {}, html_options = nil)
    html_options ||= {}
    html_options[:class] = html_options[:class].to_s.split(' ').push('btn').uniq.join(' ')
    link_to %(<span><span><b>&nbsp;</b><u>#{name}</u></span></span>).html_safe, options, html_options
  end

  def card_css_classes_string(card)
    card.colors_array.size > 1 ? 'gold' : card.colors
  end

end

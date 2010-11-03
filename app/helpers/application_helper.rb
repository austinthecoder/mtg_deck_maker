module ApplicationHelper

  def submit_button(name, options = {})
    options.merge!(:type => 'submit')
    options[:class] = options[:class].to_s.split(' ').push('btn').uniq.join(' ')
    content_tag(:button, %(<span><span><b>&nbsp;</b><u>#{name}</u></span></span>).html_safe, options)
  end

end

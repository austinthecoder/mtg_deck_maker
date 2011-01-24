module ApplicationHelper

  def javascripts
    # https://www.google.com/jsapi
    google_api_key = {
      'development' => 'ABQIAAAAuXkIcP0Zw8v8jCUkBC-IBRRoc4utMzBXt_bPptjFTNgmXxPT2RRLIIOivAWIXXqgqRHu4g1HXdWcDw',
      'staging' => 'ABQIAAAAuXkIcP0Zw8v8jCUkBC-IBRTX6enKw2hN_PRkDtXDj_raCtHNUxS2z8EPGpWNwA9UpCbYj5jShGL3jQ',
      'production' => ''
    }[Rails.env]
    [
      "https://www.google.com/jsapi?key=#{google_api_key}",
      'https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js',
      'livequery.min.js',
      'application.js'
    ]
  end

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

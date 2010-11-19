Transform /^that set$/ do |step_arg|
  MtgSet.last
end

Transform /^that card$/ do |step_arg|
  Card.last
end

def that_card
  Card.last
end
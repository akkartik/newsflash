# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def fontSize(s)
    return '100' if s.nil?
    l = s.length
    p l
    return '100' if l > 2000
    return '200' if l < 500
    100+(2000-l)/15
  end
end

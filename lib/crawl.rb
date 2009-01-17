require 'net/http'
require 'uri'

# http://www.ruby-doc.org/stdlib/libdoc/net/http/rdoc
def fetch(uri_str, limit = 10)
  # You should choose better exception.
  raise ArgumentError, 'HTTP redirect too deep' if limit == 0

  response = Net::HTTP.get_response(URI.parse(uri_str))
  case response
  when Net::HTTPSuccess     then response
  when Net::HTTPRedirection then fetch(response['location'], limit - 1)
  else
    response.error!
  end
end

response, body = fetch('http://google.com')
p body
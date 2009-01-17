require 'rfeedparser'

def updateAllFeeds
  File.read("#{RAILS_ROOT}/feeds").each do |url|
    parsedFeed = rfp(url)
    parsedFeed.entries.each do |entry|
      Post.create_or_update :url => entry.link, :title => entry.title, :feedurl => p.channel.link, :feedtitle => p.channel.title
    end
    break
  end
end

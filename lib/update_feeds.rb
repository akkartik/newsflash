require 'rfeedparser'

def updateAllFeeds
  File.read("#{RAILS_ROOT}/feeds").each do |url|
    parsedFeed = rfp(url)
    parsedFeed.entries.each do |entry|
      fields = {:url => entry.link, :title => entry.title, :feedurl => parsedFeed.channel.link, :feedtitle => parsedFeed.channel.title}
      p = Post.find_or_create_by_url fields
      p.update_attributes fields
      p.save
    end
  end
end

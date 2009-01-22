require 'rfeedparser'

def updateAllFeeds
  File.read(FEED_FILE).each do |url|
    puts url
    begin
      parsedFeed = rfp(url)
    rescue Timeout::Error
      puts "timeout. skipping"
      next
    end

    parsedFeed.entries.each do |entry|
      puts "=="
      puts "title: #{!entry.title.nil?} #{!entry.link.nil?} #{!entry.description.nil?}"
      p entry

#?       fields = {:url => entry.link, :title => entry.title, :feedurl => parsedFeed.channel.link, :feedtitle => parsedFeed.channel.title, :contents => entry.description}
#?       p = Post.find_or_create_by_url fields
#?       p.update_attributes fields
#?       p.save
    end
  end
end

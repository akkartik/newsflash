require 'rfeedparser'

def atomPermalink(entry)
  entry.links.select{|elem| ['alternate', "'alternate'"].include? elem['rel']}[0].href
end

def updateAllFeeds
  $FEEDS.each do |feedUrl|
    puts feedUrl
    begin
      parsedFeed = rfp(feedUrl)
    rescue Timeout::Error
      puts "timeout. skipping"
      next
    end

    parsedFeed.entries.reverse.each do |entry|
      description = entry.description || entry.summary || entry.content[0].value
      url = entry.link || atomPermalink(entry)

      fields = {:url => url, :title => entry.title, :contents => description,
          :feedurl => feedUrl, :homeurl => parsedFeed.channel.link, :hometitle => parsedFeed.channel.title}
      post = Post.find_or_create_by_url fields
      post.update_attributes fields
      post.save
    end
  end
end

def feedUpdateDaemon
  while(1)
    updateAllFeeds
    puts "sleeping"
    sleep 60*60
  end
end

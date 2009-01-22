require 'rfeedparser'

def atomPermalink(entry)
  entry.links.select{|elem| ['alternate', "'alternate'"].include? elem['rel']}[0].href
end

def updateAllFeeds
  File.read(FEED_FILE+".new").each do |feedUrl|
    puts feedUrl
    begin
      parsedFeed = rfp(feedUrl)
    rescue Timeout::Error
      puts "timeout. skipping"
      next
    end

    parsedFeed.entries.each do |entry|
      description = entry.description || entry.content[0].value
      url = entry.link || atomPermalink(entry)
#?       url = entry.link || entry.links[-1].href
      p url
#?       puts "title: #{!entry.title.nil?} #{!url.nil?} #{!description.nil?}"
#?       p entry
      break

#?       fields = {:url => entry.link, :title => entry.title, :feedurl => feedUrl, :feedtitle => parsedFeed.channel.title, :contents => entry.description}
#?       p = Post.find_or_create_by_url fields
#?       p.update_attributes fields
#?       p.save
    end
  end
end

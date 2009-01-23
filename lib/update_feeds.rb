require 'rfeedparser'

def atomPermalink(entry)
  entry.links.select{|elem| ['alternate', "'alternate'"].include? elem['rel']}[0].href
end

def stripQuotes(s)
  s.gsub(/^['"]|['"]$/, '')
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
      description = entry.description || entry.summary || entry.content[0].value rescue ""
      description = "" if description.length <= 10
      url = entry.link || atomPermalink(entry)
      title = entry.title
      title = "###" if title.blank? || title.length <= 10
      home = parsedFeed.channel.title
      home = "#" if home.blank?

      fields = {:url => stripQuotes(url), :title => stripQuotes(title),
          :contents => stripQuotes(description),
          :feedurl => stripQuotes(feedUrl), :homeurl => stripQuotes(parsedFeed.channel.link), :home => stripQuotes(home)}
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
    sleep 60*60*23
  end
end

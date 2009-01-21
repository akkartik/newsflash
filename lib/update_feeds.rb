require 'rfeedparser'

def retryTimeout(num=10)
  until num < 0
    begin
      yield
    rescue Timeout::Error
      puts "timeout #{num}"
      num -= 1
    end
  end
end

def getFeedWithRetries(url)
  retryTimeout do
    rfp(url)
  end
end

def updateAllFeeds
  File.read("#{RAILS_ROOT}/config/feeds").each do |url|
    puts url
    begin
      parsedFeed = rfp(url)
    rescue Timeout::Error
      puts "timeout. skipping"
      next
    end

    parsedFeed.entries.each do |entry|
      fields = {:url => entry.link, :title => entry.title, :feedurl => parsedFeed.channel.link, :feedtitle => parsedFeed.channel.title, :contents => entry.description}
      p = Post.find_or_create_by_url fields
      p.update_attributes fields
      p.save
    end
  end
end

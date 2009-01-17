require 'rubygems'
require 'rfeedparser'

def updateAllFeeds
  File.read('feeds').each do |url|
    p = rfp(url)
    next if p.entries.empty?
    p p.href
    p p.channel.link
    p p.entries[0].keys
#?     rfp(url).entries.each do |entry|
#?       puts entry.link
#?     end
    break
  end
end

updateAllFeeds

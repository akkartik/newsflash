require 'update_feeds'

namespace :feeds do
  task :update => :environment do
    reloadFeedList
    updateAllFeeds
  end
end

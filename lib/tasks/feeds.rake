require 'update_feeds'

namespace :feeds do
  task :update => :environment do
    updateAllFeeds
  end
end

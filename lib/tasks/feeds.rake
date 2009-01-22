require 'update_feeds'

namespace :feeds do
  task :update => :environment do
    feedUpdateDaemon
  end
end

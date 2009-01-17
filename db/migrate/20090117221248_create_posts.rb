class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :url, :primary_key => true
      t.string :title
      t.string :feedurl
      t.string :feedtitle
      t.text :contents
      t.boolean :doneReading, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end

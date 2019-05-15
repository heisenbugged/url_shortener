class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|      
      t.string :email
      t.string :code
      t.string :full_link
      t.timestamps
    end      
  end
end

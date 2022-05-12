class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :sanitized_url
      t.string :shortened_slug

      t.timestamps
    end
  end
end

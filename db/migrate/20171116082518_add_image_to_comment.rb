class AddImageToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :image_data, :text
  end
end

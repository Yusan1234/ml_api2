class AddPathToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :path, :string
  end
end

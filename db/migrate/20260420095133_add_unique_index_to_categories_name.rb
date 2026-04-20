# db/migrate/xxx_add_unique_index_to_categories_name.rb
class AddUniqueIndexToCategoriesName < ActiveRecord::Migration[8.0]
  def change
    add_index :categories, :name, unique: true
  end
end

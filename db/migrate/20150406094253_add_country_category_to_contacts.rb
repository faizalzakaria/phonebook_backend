class AddCountryCategoryToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :category_id, :integer, null: false
    add_column :contacts, :country, :string
  end

  def self.down
    drop_column :contacts, :category_id
    drop_column :contacts, :country
  end
end

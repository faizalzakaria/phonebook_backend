class AddFakeToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :fake, :boolean, default: false
  end

  def self.down
    remove_column :contacts, :fake
  end
end

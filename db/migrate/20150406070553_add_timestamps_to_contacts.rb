class AddTimestampsToContacts < ActiveRecord::Migration
  def self.up
    change_table :contacts do |t|
      t.timestamps
    end
  end

  def self.down
    remove_column :contacts, :created_at
    remove_column :contacts, :updated_at
  end
end

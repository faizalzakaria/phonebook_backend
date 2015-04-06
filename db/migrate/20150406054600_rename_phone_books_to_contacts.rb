class RenamePhoneBooksToContacts < ActiveRecord::Migration
  def self.up
    rename_table :phone_books, :contacts
  end

  def self.down
    rename_table :contacts, :phone_books
  end
end

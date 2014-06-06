class CreatePhoneBook < ActiveRecord::Migration
  def self.up
    create_table :phone_books, force: true do |t|
      t.string :name
      t.string :phone, limit: 20
    end
  end

  def self.down
    drop_table :phone_books
  end
end

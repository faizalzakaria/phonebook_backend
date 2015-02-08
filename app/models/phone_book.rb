class PhoneBook < ActiveRecord::Base
  attr_accessible :name, :phone

  fastapi_standard_interface [
    :id,
    :name,
    :phone
  ]

  validates :name, :phone, presence: true

  SPLITTER = "    "

  def self.download
    File.open('public/download.txt', 'w') do |file|
      file.write(PhoneBook.format_download_data)
    end
  end

  def self.upload(params)
    data = params.split("\n")
    data.each do |d|
      user = d.split(SPLITTER)
      conditions = { name: user.first, phone: user.last }
      PhoneBook.find_create_or_update!(conditions)
    end
    PhoneBook.all
  end

  def self.find_create_or_update!(conditions)
    phone_book = PhoneBook.find_by_name(conditions[:name])
    phone_book.update_attributes!(conditions) if phone_book
    phone_book ||= PhoneBook.create!(conditions)
  end

  private

  def self.format_download_data
    PhoneBook.all.reduce("") do |i, j|
      i += "#{j.name}#{SPLITTER}#{j.phone}\n"
    end
  end
end

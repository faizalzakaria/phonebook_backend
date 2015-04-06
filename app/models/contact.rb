class Contact < ActiveRecord::Base
  attr_accessible :name, :phone

  validates :name, :phone, presence: true

  SPLITTER = "    "

  def self.download
    File.open('public/download.txt', 'w') do |file|
      file.write(Contact.format_download_data)
    end
  end

  def self.upload(params)
    data = params.split("\n")
    data.each do |d|
      user = d.split(SPLITTER)
      conditions = { name: user.first, phone: user.last }
      Contact.find_create_or_update!(conditions)
    end
    Contact.all
  end

  def self.find_create_or_update!(conditions)
    contact = Contact.find_by_name(conditions[:name])
    contact.update_attributes!(conditions) if contact
    contact ||= Contact.create!(conditions)
  end

  private

  def self.format_download_data
    Contact.all.reduce("") do |i, j|
      i += "#{j.name}#{SPLITTER}#{j.phone}\n"
    end
  end
end

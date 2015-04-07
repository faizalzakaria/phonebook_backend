class Contact < ActiveRecord::Base
  attr_accessible :name, :phone, :category_id, :country, :fake

  validates :name, :phone, presence: true

  belongs_to :category
end

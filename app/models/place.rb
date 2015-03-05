class Place < ActiveRecord::Base
  validates :name, :address, presence: true

  belongs_to :category
end

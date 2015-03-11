class Place < ActiveRecord::Base
  validates :name, :address, presence: true

  belongs_to :category
  has_many :options
  has_many :plans, through: :options
end

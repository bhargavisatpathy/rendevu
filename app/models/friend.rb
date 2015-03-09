class Friend < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, }, length: { is: 10 }
end

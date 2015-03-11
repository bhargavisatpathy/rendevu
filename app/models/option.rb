class Option < ActiveRecord::Base
  belongs_to :place
  belongs_to :plan
end

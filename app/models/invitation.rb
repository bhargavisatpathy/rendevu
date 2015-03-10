class Invitation < ActiveRecord::Base
  belongs_to :plan
  belongs_to :friend
end

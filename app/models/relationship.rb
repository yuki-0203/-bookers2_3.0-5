class Relationship < ApplicationRecord
  belongs_to :following, clss_name: 'User'
  belongs_to :follower, clss_name: 'User'
end

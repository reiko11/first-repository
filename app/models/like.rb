class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates_uniqueness_of :like_id, scope: :user_id
end

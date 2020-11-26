class Post < ApplicationRecord
    validates :user_id, presence: true
    has_one_attached :image 
    belongs_to :user
end

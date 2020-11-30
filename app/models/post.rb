class Post < ApplicationRecord
    validates :user_id, presence: true
    validates :image, presence: true 
    validates :caption, presence: true, length: {minimum:3 ,maximum: 255}
    has_one_attached :image 
    belongs_to :user
    has_many :comments, dependent: :destroy
    paginates_per 3
end

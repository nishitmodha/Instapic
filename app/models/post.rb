class Post < ApplicationRecord
    acts_as_votable

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy
    
    validates :user_id, presence: true
    validates :image, presence: true 
    validates :caption, presence: true, length: {minimum:3 ,maximum: 255}
    
    has_one_attached :image 
    paginates_per 3

    scope :of_followed_users, -> (following_users) { where user_id: following_users }

end

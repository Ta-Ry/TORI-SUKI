class Post < ApplicationRecord
	belongs_to :user
  has_many :favorites, dependent: :destroy
        def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
        end
  has_many :post_comments, dependent: :destroy
  attachment :post_image
end

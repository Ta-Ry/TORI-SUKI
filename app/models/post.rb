class Post < ApplicationRecord
	belongs_to :user
  	has_many :favorites, dependent: :destroy
        def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
        end
  	has_many :post_comments, dependent: :destroy
  	attachment :post_image
  	acts_as_taggable

	validates :main_comment, presence: true, length: {maximum: 200}

  def self.search(search)
    if search
      Post.joins(
        ['LEFT JOIN users ON posts.user_id = users.id']
      ).select(
        ['id', 'user_id', 'main_comment', 'users.name', 'post_image_id']
      ).where(
        [
        'main_comment LIKE ? OR users.name LIKE ?',
        "%#{search}%",
        "%#{search}%"
        ]
      )
    else
      Post.all
    end
  end
end
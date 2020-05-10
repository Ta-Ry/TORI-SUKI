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
	validates :tag_list, presence: true

  def self.search(search)
    if search
      Post.where(['main_comment LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end
end

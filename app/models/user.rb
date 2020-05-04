class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  attachment :profile_image

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followers, through: :passive_relationships, source: :follow

  def follow(other_user)
    unless self == other_user
      self.active_relationships.find_or_create_by(follower_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.active_relationships.find_by(follower_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follow_count(user)
  	Relationship.where(follow_id: user.id)
  end

  def follower_count(user)
  	Relationship.where(follower_id: user.id)
  end

end

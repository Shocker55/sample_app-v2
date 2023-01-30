class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :active_relationships, class_name:   "Relationship",
                                    foreign_key:  "follower_id",
                                    dependent:    :destroy
  has_many :passive_relationships, class_name:   "Relationship",
                                    foreign_key:  "followed_id",
                                    dependent:    :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :article_likes, dependent: :destroy

  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 150 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def feed
    following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
    Article.where("user_id IN (#{following_ids}) 
                    OR user_id = :user_id", user_id: id)
                    .includes(:user, image_attachment: :blob)
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end

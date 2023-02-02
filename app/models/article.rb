class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  has_many :article_likes, dependent: :destroy
  has_many :iine_users, through: :article_likes, source: :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 50 }
  validates :content, presence: true
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                        message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message:    "should be less than 5MB" }
  # 記事をいいねする
  def iine(user)
    article_likes.create(user_id: user.id)
  end

  # 記事のいいねを解除する
  def uniine(user)
    article_likes.find_by(user_id: user.id).destroy
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def iine?(user)
    iine_users.include?(user)
  end
end

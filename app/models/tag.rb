class Tag < ApplicationRecord
  has_many :article_relationships, dependent: :destroy
  has_many :articles, through: :article_relationships
  validates :name, presence: true
  validates :name, uniqueness: true
end

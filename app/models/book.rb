class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  acts_as_taggable_on :tags

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "body", "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end
end
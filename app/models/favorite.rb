class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :notification, as: :notifiable, dependent: :destroy

  validates_uniqueness_of :book_id, scope: :user_id

  after_create do
    create_notification(user_id: book.user_id)
  end
end

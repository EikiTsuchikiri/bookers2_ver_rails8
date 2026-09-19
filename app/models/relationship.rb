class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  after_create do
    create_notification(user_id: book.user_id)
  end
end

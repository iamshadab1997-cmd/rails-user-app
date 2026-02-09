class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  validates :body, presence: true
  after_create :log_comment

  private

  def log_comment
    Rails.logger.info "Comment ##{id} added to #{commentable_type}##{commentable_id}"
  end
end

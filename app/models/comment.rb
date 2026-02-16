class Comment < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
  belongs_to :commentable, polymorphic: true
  belongs_to :user, optional: true   # agar comment anonymous bhi ho sakta hai

  # ---------- VALIDATIONS ----------
  validates :body, presence: true
  validates :author_name, presence: true, unless: -> { user.present? }
  validates :email, presence: true, unless: -> { user.present? }

  # ---------- CALLBACKS ----------
  after_create :log_comment

  private

  # Log comment creation
  def log_comment
    Rails.logger.info "Comment ##{id} added to #{commentable_type}##{commentable_id}" +
                      (user.present? ? " by User##{user.id}" : " by #{author_name || 'Anonymous'}")
  end
end

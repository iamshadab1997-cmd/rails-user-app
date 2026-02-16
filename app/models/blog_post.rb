class BlogPost < ApplicationRecord                # Inherits from ApplicationRecord; base model features
  belongs_to :user                                 # Each blog post belongs to a user (association)
  has_one_attached :image
  has_many :comments, as: :commentable, dependent: :destroy  # Polymorphic association; comments are destroyed if post is deleted

  validates :title, presence: true                # Title is required; cannot save a post without it

  before_validation :generate_slug                # Callback: run generate_slug before validation
  after_create :notify_followers                  # Callback: run notify_followers after record creation

  private                                        # Methods below are private, not accessible from outside

  def generate_slug
    self.slug = title.parameterize if title.present?   # Convert title to URL-friendly slug
  end

  def notify_followers
    Rails.logger.info "BlogPost ##{id} published, notifying followers..."  # Log message (can later notify actual users)
  end
end

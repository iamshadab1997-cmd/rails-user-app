class AddTitleAndReviewerNameToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :title, :string
    add_column :reviews, :reviewer_name, :string
  end
end

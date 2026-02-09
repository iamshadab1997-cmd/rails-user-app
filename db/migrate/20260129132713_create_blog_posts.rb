class CreateBlogPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.boolean :published
      t.datetime :published_at
      t.string :author_name

      t.timestamps
    end
  end
end

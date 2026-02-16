class ReviewSerializer
  include JSONAPI::Serializer

  attributes :id, :user_id, :product_id, :rating, :comment, :approved, :created_at, :updated_at
end

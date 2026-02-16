class MessageSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :receiver_id, :body, :created_at, :updated_at
end

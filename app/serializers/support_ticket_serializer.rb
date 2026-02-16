class SupportTicketSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :subject, :description, :status, :priority, :created_at, :updated_at
end

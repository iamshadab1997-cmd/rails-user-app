class AuditLogSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :action, :created_at, :updated_at
end

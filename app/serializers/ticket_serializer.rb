class TicketSerializer
  include JSONAPI::Serializer

  attributes :id, :event_id, :price, :created_at
end

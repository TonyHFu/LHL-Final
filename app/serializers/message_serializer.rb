class MessageSerializer < ActiveModel::Serializer
  attributes :id, :friendship_id, :text, :created_at
end

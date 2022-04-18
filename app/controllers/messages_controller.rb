class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    friendship = Friendship.find(message_params[:friendship_id])
    if message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(message)
      ).serializable_hash
      MessagesChannel.broadcast_to friendship, serialized_data
      head :ok
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:text, :friendship_id)
  end
end

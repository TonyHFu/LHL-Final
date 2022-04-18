class FriendshipsController < ApplicationController
  def index
    friendships = Friendship.all
    render json: friendships
  end

  def create
    friendship = Friendship.new(friendship_params)
    if friendship.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        FriendshipSerializer.new(friendship)
      ).serializable_hash
      ActionCable.server.broadcast 'friendships_channel', serialized_data
      head :ok
    end
  end
  
  private
  
  def friendship_params
    params.require(:friendship).permit(:title)
  end
end

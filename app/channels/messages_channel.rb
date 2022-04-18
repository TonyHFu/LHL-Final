class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    friendship = Friendship.find(params[:friendship])
    stream_for friendship
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

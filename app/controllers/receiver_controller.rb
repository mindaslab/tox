class ReceiverController < ApplicationController
  # This is the landing page
  def here
    session[:last_message_id] = nil
  end
  
  # This what sends updates to the receiver
  def update
    if session[:last_message_id].nil?
      @messages = Message.order(created_at: :desc)
    else
      # send messages that are older than the last sent
      last_message = Message.find session[:last_message_id]
      @messages = Message.where("id > ? and created_at >= ?", last_message.id,
      last_message.created_at.to_formatted_s(:db)).order(created_at: :desc)
    end
    
    # since the messages are inversed in time
    # the first message in this array is the last
    # one posted
    last_message = @messages.first 
    # note the last sent message
    session[:last_message_id] = last_message.id if last_message
    render layout: false
  end
  
  def create_message
    message = Message.create({content: params[:txt]})
    render nothing: true
  end
end

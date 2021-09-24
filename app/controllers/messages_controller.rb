class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_conversation!

  def create
    @conversation ||= Conversation.create(author_id: current_user.id,
                                          receiver_id: @receiver.id)
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id
    if @message.save
      ActionCable.server.broadcast "conversations_channel",
      content: @message.body,
      user_name: @message.user.user_name
    else
    end
    redirect_to conversation_path(@conversation)
  end

  def new
    redirect_to conversation_path(@conversation) and return if @conversation
    @message = current_user.messages.build
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def find_conversation!
    if params[:receiver_id]
      @receiver = User.find_by(id: params[:receiver_id])
      redirect_to(root_path) and return unless @receiver
      @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
    end
  end
end

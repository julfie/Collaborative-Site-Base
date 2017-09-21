class MessagesController < ApplicationController
	before_action :set_message, only: [:show, :edit, :update, :destroy]
	before_action :check_login

	def index
		@read_messages = Message.isread.chronological.paginate(:page => params[:page]).per_page(7)
		authorize! :index, @read_messages
		@unread_messages = Message.unread.chronological.paginate(:page => params[:page]).per_page(7)
		authorize! :index, @unread_messages
		@flagged_messages = Message.flagged.chronological.paginate(:page => params[:page]).per_page(7)
		authorize! :index, @flagged_messages
	end

	def show
		authorize! :show, @message
	end

	def new
		@message = Message.new
		authorize! :new, @message
	end

	def edit
	end

	def create
		@message = Message.new(message_params)
		@authorize! :create, @message
		@message.sender = current_user.id
		if @message.save
			flash[:notice] = "#{@message.subject} has been sent."
			redirect_to @message
		else
			render :action => 'new'
		end
	end

	def update
	end

	def destroy
		authorize! :destroy, @message
		@message.destroy
		flash[:notice] = "Successfully deleted #{@message.subject} from Messages."
		redirect_to messages_url
	end

	private

	def set_message
		@message = Message.find(params[:id])
	end

	def message_params
		params.require(:message).permit(:subject, :send_date, :sender_id, :read_status, :body, :flagged)
	end
end
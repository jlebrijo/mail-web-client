class ActiveImapMessagesController < ApplicationController
  before_filter :authenticate_user!, :load_imap_connection
  after_filter :close_connection
  # GET /active_imap_messages
  # GET /active_imap_messages.json
  def index
    @active_imap_messages = @folder.messages(:order => 'REVERSE,DATE' )
  end

  # GET /active_imap_messages/1
  # GET /active_imap_messages/1.json
  def show
    @active_imap_message = ActiveImapMessage.find(@folder,params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @active_imap_message }
    end
  end

  # DELETE /active_imap_messages/1
  # DELETE /active_imap_messages/1.json
  def destroy
    @active_imap_message = ActiveImapMessage.find(@folder, params[:id])
    @active_imap_message.delete

    respond_to do |format|
      format.html { redirect_to active_imap_messages_url }
      format.json { head :no_content }
    end
  end
  def new
    @smtp_message = SmtpMessage.new
  end  
  # POST /active_imap_messages
  def create
    InboxMailer.create_mail(current_user, params).deliver
    @folder.connection.save_sent_message(current_user.email, params)
    redirect_to :controller => 'active_imap_messages', :action => 'index', :notice => "Mail sent"

  end
  protected
  def load_imap_connection
    @connection = ActiveImap::Connection.new(current_user.email,current_user.imap_password)
    folder_name = ( params[:folder_id] == 'INBOX' ? params[:folder_id] : 'INBOX.'+params[:folder_id])
    @folder = ActiveImap::Folder.find_by_mailbox(@connection,folder_name)
  end
  def close_connection
   @connection.logout_and_disconnect 
  end
end

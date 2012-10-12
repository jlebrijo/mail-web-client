class ActiveImapMessagesController < ApplicationController
  before_filter :authenticate_user!, :load_imap_connection
  # GET /active_imap_messages
  # GET /active_imap_messages.json
  def index
    if params[:folder_id]
      @folder = ActiveImap::Folder.find_by_mailbox(@connection,@folder.mailbox + "." + params[:folder_id])
      @@imap_connections[current_user.id][:folder] = @folder
    else
      @@imap_connections[current_user.id][:folder] = ActiveImap::Folder.first(@connection)
    end
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
  # This code is to persist in RAM the IMAP connections of the people
  #
  # Study if this is useful in terms of efficiency with a local imap server
  # If doesn't improve efficiency you can simplify to this:
  #      @connection = ActiveImap::Connection.new(current_user.email,current_user.imap_password)
  #      @folder = ActiveImap::Folder.first(@connection)
  @@imap_connections = Hash.new
  def load_imap_connection
    unless @@imap_connections.empty?
      logger.info "Getting connection !!"
      if @@imap_connections.include?(current_user.id)
        @connection = @@imap_connections[current_user.id][:connection]
        @folder = @@imap_connections[current_user.id][:folder]
      end
    end
    unless @connection
      logger.info "Initializing connection !!"
      @connection = ActiveImap::Connection.new(current_user.email,current_user.imap_password)
      @folder = ActiveImap::Folder.first(@connection)
      @@imap_connections[current_user.id] = { :connection => @connection, :folder => @folder}
    end
  end
end

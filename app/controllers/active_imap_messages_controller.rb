class ActiveImapMessagesController < ApplicationController
  before_filter :load_imap_connection
  # GET /active_imap_messages
  # GET /active_imap_messages.json
  def index
    #@active_imap_messages = ActiveImapMessage.all
    @active_imap_messages = @folder.messages(:order => 'REVERSE,DATE' )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @active_imap_messages }
    end
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

  # GET /active_imap_messages/new
  # GET /active_imap_messages/new.json
  def new
    @active_imap_message = ActiveImapMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @active_imap_message }
    end
  end

  # GET /active_imap_messages/1/edit
  def edit
    @active_imap_message = ActiveImapMessage.find(params[:id])
  end

  # POST /active_imap_messages
  # POST /active_imap_messages.json
  def create
    @active_imap_message = ActiveImapMessage.new(params[:active_imap_message])

    respond_to do |format|
      if @active_imap_message.save
        format.html { redirect_to @active_imap_message, notice: 'Active imap message was successfully created.' }
        format.json { render json: @active_imap_message, status: :created, location: @active_imap_message }
      else
        format.html { render action: "new" }
        format.json { render json: @active_imap_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /active_imap_messages/1
  # PUT /active_imap_messages/1.json
  def update
    @active_imap_message = ActiveImapMessage.find(params[:id])

    respond_to do |format|
      if @active_imap_message.update_attributes(params[:active_imap_message])
        format.html { redirect_to @active_imap_message, notice: 'Active imap message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @active_imap_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /active_imap_messages/1
  # DELETE /active_imap_messages/1.json
  def destroy
    @active_imap_message = ActiveImapMessage.find(params[:id])
    @active_imap_message.destroy

    respond_to do |format|
      format.html { redirect_to active_imap_messages_url }
      format.json { head :no_content }
    end
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

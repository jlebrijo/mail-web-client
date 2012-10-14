require "spec_helper"

describe ActiveImapMessagesController do
  describe "routing" do

    it "routes to #index" do
      get("/active_imap_messages").should route_to("active_imap_messages#index")
    end

    it "routes to #new" do
      get("/active_imap_messages/new").should route_to("active_imap_messages#new")
    end

    it "routes to #show" do
      get("/active_imap_messages/1").should route_to("active_imap_messages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/active_imap_messages/1/edit").should route_to("active_imap_messages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/active_imap_messages").should route_to("active_imap_messages#create")
    end

    it "routes to #update" do
      put("/active_imap_messages/1").should route_to("active_imap_messages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/active_imap_messages/1").should route_to("active_imap_messages#destroy", :id => "1")
    end

  end
end

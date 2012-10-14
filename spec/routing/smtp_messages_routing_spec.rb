require "spec_helper"

describe SmtpMessagesController do
  describe "routing" do

    it "routes to #index" do
      get("/smtp_messages").should route_to("smtp_messages#index")
    end

    it "routes to #new" do
      get("/smtp_messages/new").should route_to("smtp_messages#new")
    end

    it "routes to #show" do
      get("/smtp_messages/1").should route_to("smtp_messages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/smtp_messages/1/edit").should route_to("smtp_messages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/smtp_messages").should route_to("smtp_messages#create")
    end

    it "routes to #update" do
      put("/smtp_messages/1").should route_to("smtp_messages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/smtp_messages/1").should route_to("smtp_messages#destroy", :id => "1")
    end

  end
end

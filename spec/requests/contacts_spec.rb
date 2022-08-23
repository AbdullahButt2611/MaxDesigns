require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe " is saved if all values are present" do
    it "returns http success" do
      post "/contacts", :params => {:contact => {name: 'Bilal', email: "bilal.ghous@gmail.com", contactNumber: "123345567", company: "Nothing yet", message: "Hey there i am using lux soap"}}
      expect(response).to have_http_status(:success)
    end
  end

  describe " is not saved if any value is not present except company" do
    it "returns the template for entering data" do
      post "/contacts", :params => {:contact => {name: 'Bilal', email: "bilal.ghous@gmail.com", company: "Nothing yet", message: "Hey there i am using lux soap"}}
      expect(response).to render_template(:new)
    end
  end

  describe " is not saved if any value is not present except company" do
    it "returns the template" do
      post "/contacts", :params => {:contact => {name: 'Bilal', email: "bilal.ghous@gmail.com", company: "Nothing yet", message: "Hey there i am using lux soap"}}
      expect(response).to render_template(:new)
    end
  end

  describe " is saved if all values are present" do
    it "even if company is not present" do
      post "/contacts", :params => {:contact => {name: 'Bilal', email: "bilal.ghous@gmail.com", contactNumber: "123345567", message: "Hey there i am using lux soap"}}
      expect(response).to have_http_status(:success)
    end
  end


  describe " is not saved if length of message is less than 10" do
    it "the message should have length of atleast ten characters" do
      post "/contacts", :params => {:contact => {name: 'Bilal', email: "bilal.ghous@gmail.com", contactNumber: "123345567", message: "Hey "}}
      expect(response).to render_template(:new)
    end
  end

  describe " is not saved if length of message is less than 10" do
    it "since it has enough letters so page is not rendered" do
      post "/contacts", :params => {:contact => {name: 'Bilal', email: "bilal.ghous@gmail.com", contactNumber: "123345567", message: "Hey there i am using lux soap"}}
      expect(response).to render_template(:new)
    end
  end

end

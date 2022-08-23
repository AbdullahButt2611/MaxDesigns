require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe " is signed up if values are present" do
    it "Ensuring email is not repeated" do
      post "/users", :params => {:user => {name: 'Bilal', email: "bilal.ghous@gmail.com",qualification: "Matric", pay: 0, contact: "123345567", encrypted_password: "Nothing yet", username: "Hey there i am using lux soap"}}
      expect(response).to have_http_status(:success)
    end
  end
end

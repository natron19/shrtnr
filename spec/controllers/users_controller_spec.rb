require 'spec_helper'

describe UsersController, type: :controller do

  let(:user) { create(:user) }
  let(:attributes) { { email: 'test@test.com', password: 'Password',
                       password_confirmation: 'Password' } }
  describe "#new" do
    it "is successfull" do
      get :new
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "changes count" do
      expect { post :create, user: attributes }.to change(User, :count).by(1)
    end
  end
end

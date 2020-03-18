require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, :michael) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }
  
  it "should redirect create when not logged in" do
    expect{
      post :create
    }.to_not change(Micropost, :count)
    expect(response).to redirect_to login_path
  end

  it "should redirect destroy when not logged in" do
    expect{
      delete :destroy, params: { id: micropost.id }
    }.to_not change(Micropost, :count)
    expect(response).to redirect_to login_path
  end

  it "should redirect destroy for wrong micropost" do
    log_in_as other_user
    expect{
      delete :destroy, params: { id: micropost.id }
    }.to_not change(Micropost, :count)
    expect(response).to redirect_to root_url
  end
end

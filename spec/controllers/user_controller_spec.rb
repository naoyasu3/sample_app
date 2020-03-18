require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, :archer) }

  it "should redirect index when not logged in" do
    get :index
    expect(response).to redirect_to login_url 
  end

  it "should get new" do
    get :new
    expect(response).to have_http_status :success
  end

  it "should redirect edit when not logged in" do
    get :edit, params: { id: user.id } 
    expect(flash.empty?).to eq false
    expect(response).to redirect_to login_url 
  end

  it "should redirect update when not logged in" do
    patch :update, params: { id: user.id } 
    expect(flash.empty?).to eq false
    expect(response).to redirect_to login_url
  end

  it "should redirect edit when logged in as wrong user" do
    log_in_as(other_user)
    get :edit, params: { id: user.id }
    expect(flash.empty?).to eq true
    expect(response).to redirect_to root_url
  end

  it "should redirect update when logged in as wrong user" do
    log_in_as(other_user)
    patch :update, params: { id: user.id }
    expect(flash.empty?).to eq true
    expect(response).to redirect_to root_url
  end

  it "should redirect destroy when not logged in" do
    expect{
      delete :destroy, params: { id: user.id }
    }.to_not change(User, :count)
    expect(response).to redirect_to login_url
  end

  it "should redirect destroy when logged in as a non-admin" do
    log_in_as(other_user)
    expect{
      delete :destroy, params: { id: user.id }
    }.to_not change(User, :count)
    expect(response).to redirect_to root_url
  end

  it "should redirect following when not logged in" do
    get :following, params: { id: user.id }
    expect(response).to redirect_to login_url
  end

  it "should redirect followers when not logged in" do
    get :followers, params: { id: user.id }
    expect(response).to redirect_to login_url
  end
end

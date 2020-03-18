require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:michael) { FactoryBot.create(:user, :michael) }
  let(:archer) { FactoryBot.create(:user, :archer) }
  let!(:relationship) { FactoryBot.create(:relationship, 
                                          follower_id: michael.id,
                                          followed_id: archer.id) }

  # before do
  #   relationship = Relationship.new(follower_id: michael.id,
  #                                   followed_id: archer.id)
  # end

  it "create should require logged-in user" do
    expect{
      post :create
    }.to_not change(Relationship, :count) 
    expect(response).to redirect_to login_url
  end

  it "destroy should require logged-in user" do
    expect{
      delete :destroy, params: { id: relationship.id }
    }.to_not change(Relationship, :count) 
    expect(response).to redirect_to login_url
  end
end

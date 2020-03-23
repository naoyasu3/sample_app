require 'rails_helper'

RSpec.describe "PasswordResetSpec", type: :system do
  let(:user) { FactoryBot.create(:user) }
  scenario 'password reset success' do
    visit login_path
    click_link '(forgot password)'
    fill_in "Email",	with: user.email 
    click_button 'Submit'
    expect(page).to have_selector('.alert-info', text: 'Email sent with password reset instructions')
  end
end
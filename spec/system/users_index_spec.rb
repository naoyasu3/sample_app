require 'rails_helper'

RSpec.describe "UsersIndexSpec", type: :system do
  it 'test' do
    visit root_path
    expect(page).to have_content 'sample app'
  end
end
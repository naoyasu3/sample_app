module SystemHelpers
  def log_in_as(user)
    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def log_in_as?
    within '.navbar-nav' do
      expect(page).to_not have_content 'Log in'
      expect(page).to have_content 'Account'
    end
  end

  def not_log_in_as?
    within '.navbar-nav' do
      expect(page).to have_content 'Log in'
      expect(page).to_not have_content 'Account'
    end
  end
end
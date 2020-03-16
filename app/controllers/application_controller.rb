class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  def hello
    render html: "hello, world!"
  end

  private
    def logged_in_user
      unless logged_in?
        #GET    /user/:id/edit
        #PATCH  /users/:id
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end

class Users::SessionsController < Devise::SessionsController
  def create
    super do |user|
      if user.host?
        redirect_to root_path and return
      else
        redirect_to participant_path(user) and return
      end
    end
  end
end

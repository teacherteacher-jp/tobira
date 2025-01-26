class Invitations::AlreadyUsedController < ApplicationController
  def index
    @invitations = Invitation.already_used.order(id: :desc)
  end
end

class InvitationsController < ApplicationController
  before_action :admin_only

  def index
    @invitations = Invitation.all
  end
end

class InvitationsController < ApplicationController
  before_action :admin_only

  def index
    @new_invitation = Invitation.new
    @invitations = Invitation.not_used.order(id: :desc)
  end

  def create
    invitation = current_member.invitations.build(invitation_params)
    invitation.save

    redirect_to(invitations_path)
  end

  def invitation_params
    params.require(:invitation).permit(:invitee_name, :role_id)
  end
end

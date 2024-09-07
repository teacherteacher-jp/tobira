class Roles::UsableController < ApplicationController
  before_action :admin_only

  def create
    role = Role.find(params[:role_id])
    role.usable = true
    role.save!

    redirect_to roles_path
  end

  def destroy
    role = Role.find(params[:role_id])
    role.usable = false
    role.save!

    redirect_to roles_path
  end
end

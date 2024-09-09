class RoleChannelsController < ApplicationController
  before_action :admin_only

  def create
    role_channel = RoleChannel.new(role_channel_params)

    if role_channel.save
      redirect_to(roles_path, notice: "通知先を設定しました")
    else
      redirect_to(roles_path, alert: "通知先の設定に失敗しました")
    end
  end

  def destroy
    role_channel = RoleChannel.find(params[:rc_id])

    if role_channel.destroy
      redirect_to(roles_path, notice: "通知先を解除しました")
    else
      redirect_to(roles_path, alert: "通知先の解除に失敗しました")
    end
  end

  def role_channel_params
    params.require(:role_channel).permit(:role_id, :channel_id)
  end
end

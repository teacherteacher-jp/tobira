class Roles::SyncController < ApplicationController
  before_action :admin_only

  def create
    Role.sync_with_server

    redirect_to(roles_path, notice: "最新のロールのデータを反映しました")
  end
end

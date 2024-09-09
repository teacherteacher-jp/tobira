class RolesController < ApplicationController
  before_action :admin_only

  def index
    @roles = Role.order(usable: :desc, id: :asc)
    @channels = Channel.text.order(position: :asc)
  end
end

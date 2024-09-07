class RolesController < ApplicationController
  before_action :admin_only

  def index
    @roles = Role.all
  end
end

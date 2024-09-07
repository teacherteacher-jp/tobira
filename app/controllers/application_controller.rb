class ApplicationController < ActionController::Base
  include SessionHelper

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :gate_check

  def gate_check
    return if logged_in?

    redirect_to(gate_path)
  end

  def admin_only
    return if current_member&.admin?

    redirect_to(root_path)
  end
end

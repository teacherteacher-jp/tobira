class ChannelsController < ApplicationController
  def index
    @categories_and_channels = Channel.text.order(:position).group_by(&:category)
  end
end

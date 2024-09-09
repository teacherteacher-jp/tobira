class Channels::SyncController < ApplicationController
  def create
    Channel.sync_with_server

    redirect_to(channels_path, notice: "最新のチャンネルのデータを反映しました")
  end
end

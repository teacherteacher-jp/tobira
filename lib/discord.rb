module Discord
  BASE_URL = "https://discord.com"
  BASE_PATH = "/api/v10"

  class Bot
    def initialize
      @bot_token = Rails.application.credentials.discord_app.bot_token
      @server_id = Rails.application.credentials.discord.server_id

      @connection = Faraday.new(
        url: BASE_URL,
        headers: {
          "Authorization" => "Bot #{@bot_token}",
          "Content-Type" => "application/json"
        }
      )
    end

    def roles
      JSON.parse(@connection.get("#{BASE_PATH}/guilds/#{@server_id}/roles").body)
    end

    def send_message(channel_or_thread_id:, content: nil, embeds: nil, allowed_mentions: nil)
      response = @connection.post("#{BASE_PATH}/channels/#{channel_or_thread_id}/messages") do |req|
        req.body = { content:, embeds:, allowed_mentions: }.to_json
      end
      JSON.parse(response.body)
    end
  end
end

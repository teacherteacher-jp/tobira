Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :discord,
    Rails.application.credentials.dig(:discord_app, :client_id),
    Rails.application.credentials.dig(:discord_app, :client_secret),
    scope: "identify"
  )
end

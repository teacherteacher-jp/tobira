Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get    "/auth/discord/callback",    to: "sessions#create"
  get    "/auth/failure",             to: "sessions#failure"
  delete "/session",                  to: "sessions#destroy", as: "session"
  get    "/gate",                     to: "gate#index"
  get    "/login",                    to: "login#index"
  get    "/invitations",              to: "invitations#index"
  post   "/invitations",              to: "invitations#create"
  get    "/invitations/already_used", to: "invitations/already_used#index"
  post   "/invitations/acceptance",   to: "invitations/acceptance#create"
  get    "/roles",                    to: "roles#index"
  post   "/roles/sync",               to: "roles/sync#create"
  post   "/roles/:role_id/usable",    to: "roles/usable#create", as: :role_usable
  delete "/roles/:role_id/usable",    to: "roles/usable#destroy"
  get    "/channels",                 to: "channels#index"
  post   "/channels/sync",            to: "channels/sync#create"
  post   "/role_channels",            to: "role_channels#create"
  delete "/role_channels/:rc_id",     to: "role_channels#destroy", as: :role_channel

  # ステップバイステップガイド
  get    "/step0",                    to: "steps#step0"
  get    "/step1",                    to: "steps#step1"
  get    "/step2",                    to: "steps#step2"
  get    "/step3",                    to: "steps#step3"

  root "root#index"
end

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get    "/auth/discord/callback", to: "sessions#create"
  delete "/session",               to: "sessions#destroy", as: "session"
  get    "/gate",                  to: "gate#index"
  get    "/invitations",           to: "invitations#index"
  get    "/roles",                 to: "roles#index"
  post   "/roles/sync",            to: "roles/sync#create"
  post   "/roles/:role_id/usable", to: "roles/usable#create", as: :role_usable
  delete "/roles/:role_id/usable", to: "roles/usable#destroy"

  root "root#index"
end

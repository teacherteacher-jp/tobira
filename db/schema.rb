# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_09_09_135049) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string "original_id", null: false
    t.string "category_id"
    t.string "name", null: false
    t.integer "type_id", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_channels_on_category_id"
    t.index ["original_id"], name: "index_channels_on_original_id", unique: true
    t.index ["position"], name: "index_channels_on_position"
    t.index ["type_id"], name: "index_channels_on_type_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "inviter_id", null: false
    t.integer "role_id", null: false
    t.string "code", null: false
    t.string "invitee_name", null: false
    t.integer "invitee_id"
    t.datetime "used_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_invitations_on_code", unique: true
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
    t.index ["role_id"], name: "index_invitations_on_role_id"
    t.index ["used_at"], name: "index_invitations_on_used_at"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.string "discord_uid", limit: 32, null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
  end

  create_table "role_channels", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_role_channels_on_channel_id"
    t.index ["role_id", "channel_id"], name: "index_role_channels_on_role_id_and_channel_id", unique: true
    t.index ["role_id"], name: "index_role_channels_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "original_id", null: false
    t.string "name", null: false
    t.boolean "usable", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["original_id"], name: "index_roles_on_original_id", unique: true
    t.index ["usable"], name: "index_roles_on_usable"
  end

  add_foreign_key "role_channels", "channels"
  add_foreign_key "role_channels", "roles"
end

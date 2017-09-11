# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170910192757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "sign_in_at"
    t.inet "sign_in_ip"
    t.string "sign_in_user_agent"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_ru"
    t.string "last_name_ru"
    t.string "first_name_en"
    t.string "last_name_en"
    t.integer "gender", limit: 2
    t.string "language"
    t.boolean "is_active", default: true
    t.datetime "sign_up_at"
    t.inet "sign_up_ip"
    t.string "sign_up_user_agent"
    t.string "country"
    t.string "city"
    t.integer "favorites_count", default: 0
    t.integer "followers_count", default: 0
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "blacklists", id: false, force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_blacklists_on_account_id"
    t.index ["user_id"], name: "index_blacklists_on_user_id"
  end

  create_table "favorites", id: false, force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_favorites_on_account_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "music_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["music_id"], name: "index_likes_on_music_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "listeners", force: :cascade do |t|
    t.bigint "music_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["music_id"], name: "index_listeners_on_music_id"
    t.index ["user_id"], name: "index_listeners_on_user_id"
  end

  create_table "mp3_files", force: :cascade do |t|
    t.bigint "account_id"
    t.string "md5_hash"
    t.string "file_name", limit: 255
    t.integer "size"
    t.integer "bitrate"
    t.integer "length"
    t.string "title"
    t.string "artist"
    t.string "album"
    t.binary "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_mp3_files_on_account_id"
    t.index ["md5_hash"], name: "index_mp3_files_on_md5_hash", unique: true
  end

  create_table "music", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "mp3_file_id"
    t.bigint "playlist_id"
    t.boolean "is_uploaded", default: false
    t.integer "likes_count", default: 0
    t.integer "play_count", default: 0
    t.integer "order", default: 0
    t.integer "size"
    t.integer "bitrate"
    t.integer "length"
    t.string "title"
    t.string "artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_music_on_account_id"
    t.index ["mp3_file_id"], name: "index_music_on_mp3_file_id"
    t.index ["playlist_id"], name: "index_music_on_playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "md5_hash"
    t.string "name"
    t.bigint "account_id"
    t.integer "music_count", default: 0
    t.binary "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_playlists_on_account_id"
  end

  add_foreign_key "blacklists", "accounts"
  add_foreign_key "blacklists", "accounts", column: "user_id"
  add_foreign_key "favorites", "accounts"
  add_foreign_key "favorites", "accounts", column: "user_id"
  add_foreign_key "likes", "accounts", column: "user_id"
  add_foreign_key "likes", "music"
  add_foreign_key "listeners", "accounts", column: "user_id"
  add_foreign_key "listeners", "music"
  add_foreign_key "mp3_files", "accounts"
  add_foreign_key "music", "accounts"
  add_foreign_key "music", "mp3_files"
  add_foreign_key "music", "playlists"
  add_foreign_key "playlists", "accounts"
end

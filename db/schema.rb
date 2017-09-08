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

ActiveRecord::Schema.define(version: 20170906160032) do

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
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

end

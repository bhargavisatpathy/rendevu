# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150315065133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friends", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "friends", ["user_id"], name: "index_friends_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.boolean  "voted"
    t.integer  "plan_id"
    t.integer  "friend_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "voting_token"
  end

  add_index "invitations", ["friend_id"], name: "index_invitations_on_friend_id", using: :btree
  add_index "invitations", ["plan_id"], name: "index_invitations_on_plan_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.integer  "rank",       default: 0
    t.integer  "place_id"
    t.integer  "plan_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "venue_id"
  end

  add_index "options", ["place_id"], name: "index_options_on_place_id", using: :btree
  add_index "options", ["plan_id"], name: "index_options_on_plan_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "places", ["category_id"], name: "index_places_on_category_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "status",     default: "open"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "time"
  end

  add_index "plans", ["user_id"], name: "index_plans_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "location"
    t.string   "provider"
    t.string   "token"
    t.string   "uid"
    t.string   "image_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_foreign_key "friends", "users"
  add_foreign_key "invitations", "friends"
  add_foreign_key "invitations", "plans"
  add_foreign_key "options", "places"
  add_foreign_key "options", "plans"
  add_foreign_key "places", "categories"
  add_foreign_key "plans", "users"
end

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

ActiveRecord::Schema.define(version: 20170921152425) do

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.string   "body"
    t.string   "invite_code"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "read_status"
    t.date     "send_date"
    t.boolean  "flagged"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "project_roles", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "role_id"
    t.integer  "user_id"
    t.integer  "invite_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "proj_description"
    t.string   "genre"
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "category"
    t.string   "status"
    t.string   "preview_level"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.boolean  "active",          default: true
    t.string   "phone"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end

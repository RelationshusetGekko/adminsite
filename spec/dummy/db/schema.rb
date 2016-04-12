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

ActiveRecord::Schema.define(version: 20160411205010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adminsite_admin_user_roles", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adminsite_admin_user_roles", ["name"], name: "index_adminsite_admin_user_roles_on_name", unique: true, using: :btree

  create_table "adminsite_admin_user_roles_users", id: false, force: :cascade do |t|
    t.integer "admin_user_id",      null: false
    t.integer "admin_user_role_id", null: false
  end

  add_index "adminsite_admin_user_roles_users", ["admin_user_id"], name: "index_adminsite_admin_user_roles_users_on_admin_user_id", using: :btree
  add_index "adminsite_admin_user_roles_users", ["admin_user_role_id"], name: "index_adminsite_admin_user_roles_users_on_admin_user_role_id", using: :btree

  create_table "adminsite_admin_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "openid_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adminsite_admin_users", ["email"], name: "index_adminsite_admin_users_on_email", unique: true, using: :btree
  add_index "adminsite_admin_users", ["reset_password_token"], name: "index_adminsite_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "adminsite_file_assets", force: :cascade do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adminsite_page_layouts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adminsite_pages", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "body"
    t.boolean  "requires_login", default: false
    t.boolean  "cacheable",      default: false
    t.integer  "page_layout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adminsite_pages", ["page_layout_id"], name: "index_adminsite_pages_on_page_layout_id", using: :btree
  add_index "adminsite_pages", ["url"], name: "index_adminsite_pages_on_url", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.string   "survey_name"
    t.datetime "survey_completed_at"
    t.datetime "survey_started_at"
    t.datetime "permission_given_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

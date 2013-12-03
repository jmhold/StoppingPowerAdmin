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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131203021839) do

  create_table "folders", :force => true do |t|
    t.string "name"
  end

  create_table "images", :force => true do |t|
    t.string   "info"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "caption"
    t.string   "image_type", :default => "proposed"
    t.string   "name"
    t.boolean  "deleted",    :default => false
    t.integer  "folder_id",  :default => 1
  end

  create_table "pairs", :force => true do |t|
    t.integer  "study_id"
    t.integer  "study_image1_id"
    t.integer  "study_image2_id"
    t.integer  "page_number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "pairs", ["study_id"], :name => "index_pairs_on_study_id"

  create_table "results", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "group_id"
    t.string   "gender"
    t.integer  "study_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "selections", :force => true do |t|
    t.integer  "study_image_id"
    t.integer  "result_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "studies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                                                                                                                                             :null => false
    t.datetime "updated_at",                                                                                                                                                             :null => false
    t.boolean  "published",    :default => false
    t.string   "caption"
    t.boolean  "active",       :default => false
    t.string   "instructions", :default => "Touch the image that gets your attention first. You have two seconds to make your choice, as indicated by the time clock above the images."
    t.float    "timer",        :default => 2.0
    t.boolean  "randomize",    :default => false
    t.integer  "warmup_pairs", :default => 0
  end

  add_index "studies", ["name"], :name => "index_studies_on_name", :unique => true

  create_table "study_images", :force => true do |t|
    t.integer  "study_id"
    t.integer  "image_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "study_images", ["study_id", "image_id"], :name => "index_study_images_on_study_id_and_image_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

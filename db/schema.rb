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

ActiveRecord::Schema.define(version: 20171004213059) do

  create_table "Users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null=>false
    t.datetime "updated_at",      :null=>false
    t.string   "password_digest"
    t.integer  "user_type",       :default=>2
    t.integer  "charge"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id",    :index=>{:name=>"index_bookings_on_user_id"}
    t.integer  "car_id",     :index=>{:name=>"index_bookings_on_car_id"}
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
    t.integer  "status"
  end

  create_table "bookings_tables", force: :cascade do |t|
    t.string   "client"
    t.string   "phone"
    t.string   "place"
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
    t.date     "starting"
    t.date     "ending"
    t.integer  "car_id",     :index=>{:name=>"index_bookings_tables_on_car_id"}
  end

  create_table "cars", force: :cascade do |t|
    t.string   "model"
    t.text     "description"
    t.string   "license_number"
    t.string   "manufacturer"
    t.string   "style"
    t.float    "price"
    t.string   "status",         :default=>"Available"
    t.string   "location"
    t.datetime "created_at",     :null=>false
    t.datetime "updated_at",     :null=>false
    t.string   "user"
    t.boolean  "email_register"
  end

  create_table "cars_tables", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "comfort_class"
    t.string   "status"
    t.float    "price"
    t.datetime "created_at",    :null=>false
    t.datetime "updated_at",    :null=>false
    t.string   "picture"
  end

end

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

ActiveRecord::Schema.define(version: 20140317082759) do

  create_table "boxoffices", force: true do |t|
    t.integer  "rid"
    t.string   "wk"
    t.string   "wboxoffice"
    t.string   "tboxoffice"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "area"
    t.string   "year"
    t.integer  "movie_id"
    t.string   "source"
  end

  add_index "boxoffices", ["movie_id"], name: "index_boxoffices_on_movie_id"

  create_table "honors", force: true do |t|
    t.string   "session"
    t.string   "year"
    t.string   "award_name"
    t.string   "award_type"
    t.string   "name"
    t.string   "festival"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "poster_url"
    t.string   "rating"
    t.string   "director"
    t.string   "actors"
    t.string   "types"
    t.string   "release_date"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "en_name"
  end

  add_index "movies", ["name"], name: "index_movies_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.string   "last_ip"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

end

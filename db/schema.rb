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

ActiveRecord::Schema.define(version: 20170912122845) do

  create_table "branch_ideas", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "community_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "idea_id"
    t.integer  "votes_count",  default: 0
    t.index ["community_id", "created_at"], name: "index_branch_ideas_on_community_id_and_created_at"
    t.index ["created_at"], name: "index_branch_ideas_on_root_id_and_created_at"
    t.index ["user_id", "created_at"], name: "index_branch_ideas_on_user_id_and_created_at"
  end

  create_table "communities", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.string   "description"
    t.integer  "leader"
    t.string   "membership_setting"
  end

  create_table "ideas", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.integer  "community_id"
    t.integer  "votes_count",  default: 0
    t.index ["community_id", "created_at"], name: "index_ideas_on_community_id_and_created_at"
    t.index ["user_id", "created_at"], name: "index_ideas_on_user_id_and_created_at"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "community_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id", "community_id"], name: "index_memberships_on_user_id_and_community_id", unique: true
  end

  create_table "temp_boxes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "community_id"
    t.integer  "idea_id"
    t.integer  "branch_idea_id"
    t.boolean  "root"
    t.index ["branch_idea_id", "created_at"], name: "index_votes_on_branch_idea_id_and_created_at"
    t.index ["community_id", "created_at"], name: "index_votes_on_community_id_and_created_at"
    t.index ["idea_id", "created_at"], name: "index_votes_on_idea_id_and_created_at"
    t.index ["user_id", "created_at"], name: "index_votes_on_user_id_and_created_at"
  end

end

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

ActiveRecord::Schema.define(version: 20180615053715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "about_us_pages", force: :cascade do |t|
    t.string   "image"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accessories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tag"
    t.string   "image"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "accessory_category_id"
    t.string   "part_number"
    t.string   "size"
    t.string   "price"
    t.string   "brand"
    t.integer  "bike_id"
  end

  create_table "accessory_categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "brand"
  end

  create_table "accessory_enquiries", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "accessory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "accessory_tags", force: :cascade do |t|
    t.integer  "accessory_id"
    t.integer  "tag_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "accessory_wishlists", force: :cascade do |t|
    t.integer  "accessory_id"
    t.integer  "wishlist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "authentication_tokens", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "last_used_at"
    t.string   "ip_address"
    t.string   "user_agent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string   "image"
    t.boolean  "active",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_host_url"
    t.integer  "display_order"
    t.string   "button_text"
    t.string   "button_link_url"
    t.string   "button_color"
    t.integer  "bike_id"
  end

  create_table "bike_colors", force: :cascade do |t|
    t.string   "label"
    t.string   "color"
    t.integer  "bike_id"
    t.string   "image"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "color_pallet_s3"
    t.boolean  "compare_visible", default: true
  end

  create_table "bike_types", force: :cascade do |t|
    t.string   "name"
    t.text     "tagline"
    t.boolean  "available",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "display_order"
  end

  create_table "bikes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "tagline"
    t.boolean  "available",            default: true
    t.integer  "bike_type_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "display_order"
    t.string   "service_schedule_url"
    t.string   "engine"
    t.integer  "bike_price"
    t.integer  "bike_cc"
    t.string   "brand"
    t.string   "warranty_url"
    t.string   "total_price"
    t.boolean  "visible",              default: true
    t.string   "web_display_image"
    t.string   "bike_brochure_url"
    t.boolean  "non_bajaj"
    t.text     "compare_vehicles"
  end

  create_table "booking_slot_controls", force: :cascade do |t|
    t.string   "dealer_location"
    t.string   "category"
    t.integer  "available_slots"
    t.date     "booking_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "booking_slots", force: :cascade do |t|
    t.string   "dealer_location"
    t.string   "category"
    t.integer  "total_slots"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "booking_time_controls", force: :cascade do |t|
    t.time     "open_time"
    t.time     "end_time"
    t.integer  "days_prior"
    t.string   "weekday"
    t.string   "category"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bulk_notifications", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.string   "category"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "careers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.integer  "experience_years"
    t.integer  "experience_months"
    t.string   "current_company"
    t.string   "cover_letter"
    t.string   "cv_file"
    t.integer  "job_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "contact_numbers", force: :cascade do |t|
    t.string   "category"
    t.string   "number"
    t.string   "label"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "contact_type_id"
  end

  create_table "contact_types", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "contact_type"
  end

  create_table "customer_galleries", force: :cascade do |t|
    t.string   "video_url"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "powered_by"
  end

  create_table "dealer_contact_labels", force: :cascade do |t|
    t.string   "label_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealer_contact_numbers", force: :cascade do |t|
    t.string   "number"
    t.integer  "dealer_id"
    t.integer  "dealer_contact_label_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "display_order"
  end

  create_table "dealer_types", force: :cascade do |t|
    t.string   "dealer_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dealer_types_dealers", force: :cascade do |t|
    t.integer  "dealer_id"
    t.integer  "dealer_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "dealers", force: :cascade do |t|
    t.string   "dealer_name"
    t.string   "address"
    t.string   "working_hours"
    t.text     "email"
    t.string   "latitude"
    t.string   "longitude"
    t.boolean  "active",                default: true
    t.string   "image"
    t.integer  "service_display_order"
    t.integer  "sales_display_order"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "dealer_type_id"
    t.string   "mobile"
  end

  create_table "default_bike_images", force: :cascade do |t|
    t.string   "image_url"
    t.integer  "bike_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "web_s3_url"
    t.string   "mobile_s3_url"
    t.string   "overview_url"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "email_notification_templates", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.string   "category"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "email_price_lists", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.integer  "varient_id"
    t.boolean  "followed_up"
    t.integer  "user_id"
    t.string   "comments"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "category"
  end

  create_table "enquiries", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "category"
    t.text     "message"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "dealer_location"
    t.string   "bike"
  end

  create_table "events", force: :cascade do |t|
    t.date     "event_date"
    t.time     "event_time"
    t.string   "location"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "coordinator_name",   default: "N/A"
    t.string   "coordinator_mobile"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.string   "feedback_type"
    t.text     "comment"
    t.integer  "rating"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "dealer_location"
  end

  create_table "finance_documents", force: :cascade do |t|
    t.string   "category"
    t.text     "document_list"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "family"
  end

  create_table "galleries", force: :cascade do |t|
    t.integer  "bike_id"
    t.text     "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hog_registrations", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "mobile"
    t.date     "dob"
    t.string   "gender"
    t.string   "bike_owned"
    t.string   "riding_since"
    t.string   "address"
    t.string   "location"
    t.string   "profession"
    t.text     "bio"
    t.boolean  "hog_privacy"
    t.string   "profile_image"
    t.integer  "user_id"
    t.boolean  "show_hog",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "insurance_renewals", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "address"
    t.string   "bike"
    t.date     "purchase_date"
    t.integer  "kms"
    t.string   "registration_number"
    t.string   "insurance_company"
    t.string   "policy_number"
    t.string   "expiry_date"
    t.string   "status",              default: "Not Followed-Up"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.text     "required_skills"
    t.string   "location"
    t.string   "technologies_required"
    t.string   "experience_required"
    t.string   "interview"
    t.string   "note"
    t.string   "notice_period"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "key_feature_types", force: :cascade do |t|
    t.string   "feature_type_name"
    t.boolean  "active",            default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "key_features", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.integer  "bike_id"
    t.integer  "key_feature_type_id"
    t.boolean  "active",              default: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "varient_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "merchant_id"
    t.string   "salt"
    t.string   "name"
    t.string   "location"
    t.string   "merchant_type"
    t.string   "merchant_key"
    t.string   "mobile"
    t.string   "email"
    t.string   "authorization"
    t.text     "payment_for"
    t.text     "dealer_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "model_full_images", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "bike_id"
    t.string   "video_url"
    t.string   "category"
    t.string   "color_name"
  end

  create_table "my_bikes", force: :cascade do |t|
    t.string   "bike"
    t.date     "purchase_date"
    t.string   "registration_number"
    t.string   "insurance_provider"
    t.string   "insurance_number"
    t.date     "insurance_expiry_date"
    t.string   "engine_number"
    t.date     "last_service_date"
    t.integer  "user_id"
    t.string   "bike_image"
    t.integer  "kms"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "default_bike_image_id"
    t.string   "my_bike_image_url"
    t.integer  "bike_id"
    t.string   "image_host_url"
    t.string   "status",                default: "Active"
  end

  create_table "my_docs", force: :cascade do |t|
    t.string   "image"
    t.string   "document_name"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "file_type"
  end

  create_table "notification_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_counts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bookings",    default: 0
    t.integer  "offer",       default: 0
    t.integer  "events",      default: 0
    t.integer  "accessories", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "count",       default: 0
    t.integer  "tips",        default: 0
  end

  create_table "notification_templates", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.string   "category"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "actor_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "notification_template_id"
    t.integer  "parent_id"
    t.boolean  "status",                   default: false
    t.integer  "bulk_notification_id"
    t.text     "content"
    t.string   "title"
  end

  create_table "payment_histories", force: :cascade do |t|
    t.integer  "payment_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "txn_id"
    t.integer  "user_id"
    t.string   "entity_type"
    t.decimal  "amount",              precision: 8, scale: 2, default: 0.0
    t.string   "status",                                      default: "Generated"
    t.integer  "merchant_id"
    t.string   "payment_type"
    t.string   "location"
    t.string   "vehicle_name"
    t.integer  "bike_id"
    t.string   "mihpayid"
    t.string   "image"
    t.string   "web_pay_image"
    t.string   "file_type"
    t.string   "payuid"
    t.text     "message"
    t.boolean  "refund"
    t.integer  "dealer_id"
    t.string   "phone"
    t.string   "booking_person_name"
    t.string   "payment_mode"
    t.string   "split_status"
    t.string   "release_status"
    t.integer  "split_payment_id"
    t.integer  "child_payment_id"
    t.integer  "refund_id"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  create_table "price_fields", force: :cascade do |t|
    t.string   "name"
    t.integer  "display_order"
    t.boolean  "active",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "pricings", force: :cascade do |t|
    t.integer  "price_field_id"
    t.string   "value"
    t.integer  "bike_id"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "varient_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "full_name"
    t.string   "mobile"
    t.string   "email"
    t.date     "dob"
    t.string   "gender"
    t.string   "bike_owned"
    t.string   "riding_since"
    t.string   "address"
    t.string   "location"
    t.string   "profession"
    t.text     "bio"
    t.boolean  "hog_privacy",               default: false
    t.string   "profile_image"
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "notifiable_offers",         default: true
    t.boolean  "notifiable_events",         default: true
    t.boolean  "notifiable_bookings",       default: true
    t.boolean  "notifiable_accessories",    default: true
    t.date     "marriage_anniversary_date"
    t.boolean  "notifiable_tips",           default: true
  end

  create_table "rides", force: :cascade do |t|
    t.date     "ride_date"
    t.string   "route"
    t.string   "distance"
    t.string   "assembly_location"
    t.string   "destination_location"
    t.boolean  "notify"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "title"
    t.text     "assembly_time"
    t.text     "destination_time"
    t.text     "check_points"
    t.string   "coordinator_name",     default: "N/A"
    t.string   "coordinator_mobile"
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "service_bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "my_bike_id"
    t.string   "registration_number"
    t.integer  "kms"
    t.date     "service_date"
    t.datetime "service_time"
    t.string   "service_station"
    t.text     "comments"
    t.string   "service_type"
    t.boolean  "request_pick_up",     default: false
    t.string   "service_status",      default: "Requested"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "status",              default: "Active"
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "address"
  end

  create_table "service_histories", force: :cascade do |t|
    t.date     "service_date"
    t.string   "service_type"
    t.integer  "kms"
    t.string   "total_cost"
    t.string   "bill_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "my_bike_id"
    t.string   "document_name"
    t.string   "file_type"
  end

  create_table "service_numbers", force: :cascade do |t|
    t.string   "contact_name"
    t.string   "contact_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "service_schedules", force: :cascade do |t|
    t.string   "service_number"
    t.integer  "bike_id"
    t.integer  "months"
    t.integer  "total_kms"
    t.string   "service_type"
    t.integer  "range"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "set_booking_numbers", force: :cascade do |t|
    t.string   "booking_number"
    t.string   "category"
    t.string   "label"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "set_mails", force: :cascade do |t|
    t.string   "email"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "location"
  end

  create_table "set_rules", force: :cascade do |t|
    t.text     "days"
    t.string   "category"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "social_media_links", force: :cascade do |t|
    t.string   "social_media_name"
    t.string   "social_media_url"
    t.integer  "display_order"
    t.boolean  "visible",           default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "specification_names", force: :cascade do |t|
    t.string   "name"
    t.integer  "specification_type_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "specification_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "display_order"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "specifications", force: :cascade do |t|
    t.string   "name"
    t.integer  "specification_type_id"
    t.integer  "bike_id"
    t.string   "value"
    t.boolean  "active"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "compare_visible",       default: true
    t.integer  "specification_name_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "accessory_category_id"
  end

  create_table "tenures", force: :cascade do |t|
    t.string   "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_rides", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.text     "address"
    t.boolean  "request_pick_up",     default: false
    t.boolean  "test_ride_done",      default: false
    t.boolean  "test_ride_confirmed", default: false
    t.string   "bike"
    t.date     "ride_date",                              null: false
    t.datetime "ride_time",                              null: false
    t.string   "location"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "status",              default: "Active"
  end

  create_table "testmonials", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.boolean  "visible"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.string   "email"
    t.string   "mobile"
  end

  create_table "used_bike_enquiries", force: :cascade do |t|
    t.string   "model"
    t.string   "registration_number"
    t.integer  "kms"
    t.integer  "manufacture_year"
    t.string   "dealer_number"
    t.integer  "price"
    t.string   "dealer_location"
    t.text     "comment"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "email"
    t.string   "name"
    t.string   "mobile"
    t.string   "address"
  end

  create_table "used_bike_images", force: :cascade do |t|
    t.string   "image"
    t.integer  "used_bike_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "used_bike_models", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "used_bikes", force: :cascade do |t|
    t.string   "make_coompany"
    t.string   "model"
    t.string   "bike_type"
    t.string   "registration_number"
    t.integer  "manufacture_year"
    t.integer  "kms"
    t.string   "gear"
    t.string   "color"
    t.string   "ownership"
    t.integer  "price"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
    t.integer  "used_bike_model_id"
    t.string   "contact_number"
    t.string   "bike_variant"
    t.string   "status"
    t.integer  "dealer_id"
    t.boolean  "for_sell",            default: false
    t.boolean  "under_warrenty",      default: false
    t.boolean  "exchange",            default: false
  end

  create_table "user_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "perticipate_event"
  end

  create_table "user_rides", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ride_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "perticipate_ride"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           default: "",      null: false
    t.string   "encrypted_password",              default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "authentication_token_created_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "role",                            default: "guest"
    t.string   "ios_token"
    t.string   "android_token"
    t.boolean  "social_login",                    default: false
    t.string   "facebook_id"
    t.string   "store_password"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "value_added_services", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "model"
    t.date     "date_of_purchase"
    t.string   "frame_number"
    t.text     "select_scheme"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "registration_number"
  end

  create_table "varients", force: :cascade do |t|
    t.string   "varient_name"
    t.string   "fuel_type"
    t.string   "transmission_type"
    t.integer  "bike_id"
    t.string   "cc"
    t.string   "gear"
    t.string   "mileage"
    t.boolean  "visible"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "vehicle_faqs", force: :cascade do |t|
    t.string   "bike_type"
    t.string   "cate_gory_type"
    t.string   "specification"
    t.string   "value"
    t.integer  "bike_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "vehicle_faqs", ["bike_id"], name: "index_vehicle_faqs_on_bike_id", using: :btree

  create_table "version_controls", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "current_version"
    t.string   "latest_version"
    t.boolean  "allow_update",    default: false
    t.boolean  "force_update",    default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "web_banners", force: :cascade do |t|
    t.string   "image"
    t.string   "s3_image_url"
    t.boolean  "active",          default: true
    t.boolean  "boolean",         default: true
    t.integer  "display_order"
    t.integer  "integer"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "button_color"
    t.string   "button_link_url"
    t.string   "button_text"
    t.boolean  "button_visible",  default: true
    t.integer  "bike_id"
  end

  create_table "web_car_colors", force: :cascade do |t|
    t.integer  "car_id"
    t.text     "s3_image_url"
    t.text     "s3_pallet_image_url"
    t.text     "color_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "web_car_galleries", force: :cascade do |t|
    t.integer  "car_id"
    t.text     "image_url"
    t.text     "diff_int_ext"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "web_display_car_images", force: :cascade do |t|
    t.string   "image_url"
    t.integer  "car_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "whatsapp_chats", force: :cascade do |t|
    t.string   "contact_number"
    t.text     "default_message"
    t.string   "label"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "count",      default: 0
  end

end

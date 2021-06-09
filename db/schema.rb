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

ActiveRecord::Schema.define(:version => 20191209092729) do

  create_table "act_load_list_lines", :force => true do |t|
    t.integer  "carrying_bill_id",                :null => false
    t.integer  "act_load_list_id",                :null => false
    t.integer  "load_num",         :default => 0, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "confirm_num",      :default => 0
    t.integer  "exception_num",    :default => 0
  end

  create_table "act_load_lists", :force => true do |t|
    t.integer  "load_list_id"
    t.date     "bill_date"
    t.integer  "from_org_id",                                     :null => false
    t.integer  "to_org_id"
    t.string   "note"
    t.string   "state",        :limit => 20, :default => "draft", :null => false
    t.integer  "user_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "bill_no",      :limit => 20
    t.string   "type",         :limit => 60
  end

  create_table "address_books", :force => true do |t|
    t.integer  "org_id"
    t.string   "province_code",        :limit => 20
    t.string   "city_code",            :limit => 20
    t.string   "district_code",        :limit => 20
    t.string   "name",                 :limit => 60,                   :null => false
    t.string   "address",              :limit => 60,                   :null => false
    t.string   "phone",                :limit => 60,                   :null => false
    t.integer  "order_by"
    t.boolean  "is_active",                          :default => true
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "leader",               :limit => 30
    t.text     "note"
    t.string   "tag",                  :limit => 40
    t.string   "simp_name",            :limit => 10
    t.string   "leader_mobile",        :limit => 30
    t.string   "second_leader",        :limit => 30
    t.string   "second_leader_mobile", :limit => 30
  end

  add_index "address_books", ["org_id"], :name => "index_address_books_on_org_id"

  create_table "adjust_fee_infos", :force => true do |t|
    t.integer  "org_id",                                                                  :null => false
    t.integer  "op_org_id",                                                               :null => false
    t.integer  "user_id"
    t.integer  "op_user_id"
    t.date     "bill_date",                                                               :null => false
    t.datetime "op_datetime"
    t.string   "state",                                              :default => "draft", :null => false
    t.decimal  "adjust_fee",          :precision => 10, :scale => 2, :default => 0.0
    t.text     "note"
    t.integer  "carrying_bill_id"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.decimal  "origin_carrying_fee", :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "adjust_fee_infos", ["carrying_bill_id"], :name => "index_adjust_fee_infos_on_carrying_bill_id"
  add_index "adjust_fee_infos", ["op_org_id"], :name => "index_adjust_fee_infos_on_op_org_id"
  add_index "adjust_fee_infos", ["op_user_id"], :name => "index_adjust_fee_infos_on_op_user_id"
  add_index "adjust_fee_infos", ["org_id"], :name => "index_adjust_fee_infos_on_org_id"
  add_index "adjust_fee_infos", ["user_id"], :name => "index_adjust_fee_infos_on_user_id"

  create_table "adjust_goods_fee_infos", :force => true do |t|
    t.integer  "org_id",                                                                               :null => false
    t.integer  "op_org_id",                                                                            :null => false
    t.integer  "user_id",                                                                              :null => false
    t.date     "bill_date",                                                                            :null => false
    t.datetime "op_datetime"
    t.string   "state",                                                           :default => "draft", :null => false
    t.integer  "carrying_bill_id",                                                                     :null => false
    t.decimal  "origin_goods_fee",                 :precision => 15, :scale => 2
    t.decimal  "adjust_goods_fee",                 :precision => 15, :scale => 2
    t.text     "note"
    t.datetime "created_at",                                                                           :null => false
    t.datetime "updated_at",                                                                           :null => false
    t.integer  "op_user_id"
    t.string   "other_adjust_note", :limit => 200
  end

  add_index "adjust_goods_fee_infos", ["carrying_bill_id"], :name => "index_adjust_goods_fee_infos_on_carrying_bill_id"
  add_index "adjust_goods_fee_infos", ["op_user_id"], :name => "index_adjust_goods_fee_infos_on_op_user_id"
  add_index "adjust_goods_fee_infos", ["org_id"], :name => "index_adjust_goods_fee_infos_on_org_id"
  add_index "adjust_goods_fee_infos", ["user_id"], :name => "index_adjust_goods_fee_infos_on_user_id"

  create_table "areas", :force => true do |t|
    t.string   "name",       :limit => 20,                   :null => false
    t.integer  "order_by",                 :default => 0
    t.boolean  "is_active",                :default => true
    t.text     "note"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "simp_name",  :limit => 20
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "banks", :force => true do |t|
    t.string   "name",                                       :null => false
    t.string   "code",       :limit => 20,                   :null => false
    t.boolean  "is_active",                :default => true
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "base_vote_config_orgs", :force => true do |t|
    t.integer  "base_vote_config_id", :null => false
    t.integer  "org_id",              :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "base_vote_config_orgs", ["base_vote_config_id"], :name => "index_base_vote_config_orgs_on_base_vote_config_id"
  add_index "base_vote_config_orgs", ["org_id"], :name => "index_base_vote_config_orgs_on_org_id"

  create_table "bill_association_objects", :force => true do |t|
    t.integer  "from_customer_id"
    t.integer  "to_customer_id"
    t.datetime "created_at",                                                                             :null => false
    t.datetime "updated_at",                                                                             :null => false
    t.integer  "customerable_id",                                                                        :null => false
    t.string   "customerable_type",      :limit => 60,                                                   :null => false
    t.boolean  "is_deliver",                                                          :default => false
    t.boolean  "is_urgent",                                                           :default => false
    t.boolean  "is_receipt",                                                          :default => false
    t.boolean  "is_list",                                                             :default => false
    t.decimal  "from_org_divide_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_org_divide_fee",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_org_divide_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "summary_org_divide_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "other_org_1_id"
    t.decimal  "other_org_1_divide_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "other_org_2_id"
    t.decimal  "other_org_2_divide_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "other_org_3_id"
    t.decimal  "other_org_3_divide_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "other_org_4_id"
    t.decimal  "other_org_4_divide_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "is_outside",                                                          :default => false
  end

  add_index "bill_association_objects", ["customerable_id"], :name => "index_bill_association_objects_on_customerable_id"
  add_index "bill_association_objects", ["customerable_type"], :name => "index_bill_association_objects_on_customerable_type"
  add_index "bill_association_objects", ["from_customer_id"], :name => "index_bill_association_objects_on_from_customer_id"
  add_index "bill_association_objects", ["other_org_1_id"], :name => "index_bill_association_objects_on_other_org_1_id"
  add_index "bill_association_objects", ["other_org_2_id"], :name => "index_bill_association_objects_on_other_org_2_id"
  add_index "bill_association_objects", ["other_org_3_id"], :name => "index_bill_association_objects_on_other_org_3_id"
  add_index "bill_association_objects", ["other_org_4_id"], :name => "index_bill_association_objects_on_other_org_4_id"
  add_index "bill_association_objects", ["to_customer_id"], :name => "index_bill_association_objects_on_to_customer_id"

  create_table "bill_lines", :force => true do |t|
    t.integer  "carrying_bill_id",                                                               :null => false
    t.integer  "goods_cat_id"
    t.integer  "qty",                                                           :default => 1
    t.string   "package"
    t.decimal  "volume",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "weight",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "amt",                            :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                     :null => false
    t.datetime "updated_at",                                                                     :null => false
    t.integer  "fee_unit_id"
    t.string   "name",             :limit => 60
  end

  add_index "bill_lines", ["carrying_bill_id"], :name => "index_bill_lines_on_carrying_bill_id"
  add_index "bill_lines", ["goods_cat_id"], :name => "index_bill_lines_on_goods_cat_id"

  create_table "bill_nos", :force => true do |t|
    t.integer  "bill_count", :default => 4000000
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "bill_notes", :force => true do |t|
    t.string   "note",             :limit => 60, :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "carrying_bill_id",               :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "bill_notes", ["carrying_bill_id"], :name => "index_bill_notes_on_carrying_bill_id"
  add_index "bill_notes", ["user_id"], :name => "index_bill_notes_on_user_id"

  create_table "carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                           :null => false
    t.string   "bill_no",                          :limit => 30,                                                      :null => false
    t.string   "goods_no",                         :limit => 30,                                                      :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                      :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                      :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                  :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                    :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                      :null => false
    t.integer  "goods_num",                                                                      :default => 1
    t.decimal  "goods_weight",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                    :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 100
    t.string   "state",                            :limit => 60
    t.boolean  "completed",                                                                      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                          :null => false
    t.datetime "updated_at",                                                                                          :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                 :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                 :default => "draft"
    t.integer  "print_counter",                                                                  :default => 0,       :null => false
    t.integer  "goods_cat_id"
    t.decimal  "unit_price",                                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "carrying_fee_1st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee_2st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "adjust_carrying_fee",                             :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "manage_fee",                                      :precision => 10, :scale => 2, :default => 0.0
    t.integer  "th_bill_print_count",                                                            :default => 0
    t.string   "additional_state",                 :limit => 30,                                 :default => "draft"
    t.string   "additional_note",                  :limit => 120
    t.integer  "short_list_id"
    t.string   "bank_name",                        :limit => 40
    t.string   "card_no",                          :limit => 40
  end

  add_index "carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "carrying_bills", ["created_at"], :name => "index_carrying_bills_on_created_at"
  add_index "carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "carrying_bills", ["distribution_list_id"], :name => "index_carrying_bills_on_distribution_list_id"
  add_index "carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "carrying_bills", ["goods_cat_id"], :name => "index_carrying_bills_on_goods_cat_id"
  add_index "carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "carrying_bills", ["short_list_id"], :name => "index_carrying_bills_on_short_list_id"
  add_index "carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "carrying_bills", ["updated_at"], :name => "index_carrying_bills_on_updated_at"
  add_index "carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "carrying_fee_th_rpts", :force => true do |t|
    t.date     "bill_date",                                                    :null => false
    t.integer  "from_org_id",                                                  :null => false
    t.integer  "to_org_id",                                                    :null => false
    t.decimal  "carrying_fee", :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  add_index "carrying_fee_th_rpts", ["bill_date"], :name => "index_carrying_fee_th_rpts_on_bill_date"
  add_index "carrying_fee_th_rpts", ["from_org_id"], :name => "index_carrying_fee_th_rpts_on_from_org_id"
  add_index "carrying_fee_th_rpts", ["to_org_id"], :name => "index_carrying_fee_th_rpts_on_to_org_id"

  create_table "claims", :force => true do |t|
    t.integer  "goods_exception_id",                                :null => false
    t.integer  "user_id"
    t.date     "bill_date"
    t.decimal  "act_compensate_fee", :precision => 15, :scale => 2
    t.text     "note"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "claims", ["bill_date"], :name => "index_claims_on_bill_date"
  add_index "claims", ["goods_exception_id"], :name => "index_claims_on_goods_exception_id"
  add_index "claims", ["user_id"], :name => "index_claims_on_user_id"

  create_table "config_cashes", :force => true do |t|
    t.decimal  "fee_from",   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "fee_to",     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "hand_fee",   :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "is_active",                                 :default => true,  :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.integer  "org_id"
    t.integer  "to_org_id"
    t.decimal  "rate",       :precision => 10, :scale => 4, :default => 0.001
  end

  create_table "config_transits", :force => true do |t|
    t.string   "name",       :limit => 20
    t.decimal  "rate",                     :precision => 10, :scale => 4, :default => 0.001
    t.boolean  "is_active",                                               :default => true,  :null => false
    t.string   "note"
    t.datetime "created_at",                                                                 :null => false
    t.datetime "updated_at",                                                                 :null => false
    t.integer  "org_id"
    t.integer  "to_org_id"
  end

  create_table "customer_fee_info_lines", :force => true do |t|
    t.integer  "customer_fee_info_id"
    t.string   "name",                 :limit => 20,                                                 :null => false
    t.string   "phone",                :limit => 30
    t.decimal  "fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                         :null => false
    t.datetime "updated_at",                                                                         :null => false
    t.string   "code",                 :limit => 20
  end

  add_index "customer_fee_info_lines", ["customer_fee_info_id"], :name => "index_customer_fee_info_lines_on_customer_fee_info_id"

  create_table "customer_fee_infos", :force => true do |t|
    t.integer  "org_id",                  :null => false
    t.string   "mth",        :limit => 6, :null => false
    t.integer  "user_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "customer_fee_infos", ["mth"], :name => "index_customer_fee_infos_on_mth"
  add_index "customer_fee_infos", ["org_id"], :name => "index_customer_fee_infos_on_org_id"
  add_index "customer_fee_infos", ["user_id"], :name => "index_customer_fee_infos_on_user_id"

  create_table "customer_level_configs", :force => true do |t|
    t.integer  "org_id",                                                                   :null => false
    t.string   "name",       :limit => 20,                                                 :null => false
    t.decimal  "from_fee",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_fee",                   :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  add_index "customer_level_configs", ["org_id"], :name => "index_customer_level_configs_on_org_id"

  create_table "customer_payment_info_lines", :force => true do |t|
    t.integer  "customer_payment_info_id"
    t.integer  "carrying_bill_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "customer_payment_info_lines", ["carrying_bill_id"], :name => "index_customer_payment_info_lines_on_carrying_bill_id"
  add_index "customer_payment_info_lines", ["customer_payment_info_id"], :name => "index_customer_payment_info_lines_on_customer_payment_info_id"

  create_table "customer_payment_infos", :force => true do |t|
    t.string   "bill_no",          :limit => 20
    t.date     "bill_date",                      :null => false
    t.string   "customer_name",    :limit => 30, :null => false
    t.string   "customer_id_no",   :limit => 60
    t.string   "pay_type",         :limit => 40, :null => false
    t.string   "pay_ref",          :limit => 60
    t.text     "note"
    t.integer  "from_org_id",                    :null => false
    t.integer  "user_id"
    t.datetime "confirm_datetime"
    t.integer  "confirm_user"
    t.string   "state"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "customer_payment_infos", ["user_id"], :name => "index_customer_payment_infos_on_user_id"

  create_table "customers", :force => true do |t|
    t.integer  "org_id"
    t.string   "name",                    :limit => 60,                                                    :null => false
    t.string   "phone",                   :limit => 20
    t.string   "mobile",                  :limit => 20
    t.string   "address",                 :limit => 60
    t.string   "company",                 :limit => 60
    t.string   "code",                    :limit => 20
    t.string   "id_number",               :limit => 30
    t.integer  "bank_id"
    t.string   "bank_card",               :limit => 30
    t.boolean  "is_active",                                                             :default => true
    t.text     "note"
    t.datetime "created_at",                                                                               :null => false
    t.datetime "updated_at",                                                                               :null => false
    t.string   "type",                    :limit => 20
    t.integer  "config_transit_id"
    t.decimal  "cur_fee",                                :precision => 15, :scale => 2
    t.string   "level",                   :limit => 20
    t.string   "last_import_mth",         :limit => 6
    t.string   "state",                   :limit => 20
    t.string   "vip_state",               :limit => 20,                                                    :null => false
    t.integer  "deliver_region_id"
    t.boolean  "vip_flag",                                                              :default => false
    t.string   "mobile_2",                :limit => 20
    t.string   "mobile_3",                :limit => 20
    t.string   "mobile_4",                :limit => 20
    t.string   "mobile_5",                :limit => 20
    t.string   "usually_location",        :limit => 200
    t.string   "sales_man",               :limit => 30
    t.string   "sales_man_mobile",        :limit => 30
    t.boolean  "is_month_pay",                                                          :default => false
    t.boolean  "is_qrcode_pay",                                                         :default => false
    t.string   "qr_photo_1_file_name"
    t.string   "qr_photo_1_content_type"
    t.integer  "qr_photo_1_file_size"
    t.datetime "qr_photo_1_updated_at"
    t.string   "qr_photo_2_file_name"
    t.string   "qr_photo_2_content_type"
    t.integer  "qr_photo_2_file_size"
    t.datetime "qr_photo_2_updated_at"
  end

  add_index "customers", ["bank_card"], :name => "index_customers_on_bank_card"
  add_index "customers", ["bank_id"], :name => "index_customers_on_bank_id"
  add_index "customers", ["code"], :name => "index_customers_on_code"
  add_index "customers", ["id_number"], :name => "index_customers_on_id_number"
  add_index "customers", ["is_active"], :name => "index_customers_on_is_active"
  add_index "customers", ["last_import_mth"], :name => "index_customers_on_last_import_mth"
  add_index "customers", ["level"], :name => "index_customers_on_level"
  add_index "customers", ["mobile"], :name => "index_customers_on_mobile"
  add_index "customers", ["name"], :name => "index_customers_on_name"
  add_index "customers", ["org_id"], :name => "index_customers_on_org_id"
  add_index "customers", ["phone"], :name => "index_customers_on_phone"
  add_index "customers", ["state"], :name => "index_customers_on_state"
  add_index "customers", ["type"], :name => "index_customers_on_type"

  create_table "debt_bill_lines", :force => true do |t|
    t.integer  "debt_bill_id",     :null => false
    t.integer  "carrying_bill_id", :null => false
    t.text     "note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "debt_bill_lines", ["carrying_bill_id"], :name => "index_debt_bill_lines_on_carrying_bill_id"
  add_index "debt_bill_lines", ["debt_bill_id"], :name => "index_debt_bill_lines_on_debt_bill_id"

  create_table "debt_bills", :force => true do |t|
    t.date     "bill_date",                :null => false
    t.integer  "org_id",                   :null => false
    t.integer  "op_org_id",                :null => false
    t.integer  "user_id"
    t.string   "state",      :limit => 20, :null => false
    t.text     "note"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "debt_bills", ["bill_date"], :name => "index_debt_bills_on_bill_date"
  add_index "debt_bills", ["op_org_id"], :name => "index_debt_bills_on_op_org_id"
  add_index "debt_bills", ["org_id"], :name => "index_debt_bills_on_org_id"
  add_index "debt_bills", ["state"], :name => "index_debt_bills_on_state"
  add_index "debt_bills", ["user_id"], :name => "index_debt_bills_on_user_id"

  create_table "deliver_infos", :force => true do |t|
    t.date     "deliver_date",                       :null => false
    t.integer  "user_id"
    t.string   "customer_name",        :limit => 60, :null => false
    t.string   "customer_no",          :limit => 30
    t.string   "state",                :limit => 30
    t.text     "note"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "org_id",                             :null => false
    t.string   "type",                 :limit => 60
    t.string   "photo_1_file_name"
    t.string   "photo_1_content_type"
    t.integer  "photo_1_file_size"
    t.datetime "photo_1_updated_at"
    t.string   "photo_2_file_name"
    t.string   "photo_2_content_type"
    t.integer  "photo_2_file_size"
    t.datetime "photo_2_updated_at"
  end

  add_index "deliver_infos", ["deliver_date"], :name => "index_deliver_infos_on_deliver_date"
  add_index "deliver_infos", ["org_id"], :name => "index_deliver_infos_on_org_id"
  add_index "deliver_infos", ["state"], :name => "index_deliver_infos_on_state"
  add_index "deliver_infos", ["user_id"], :name => "index_deliver_infos_on_user_id"

  create_table "deliver_regions", :force => true do |t|
    t.integer  "org_id",                                        :null => false
    t.string   "name",          :limit => 60,                   :null => false
    t.string   "province_code"
    t.string   "city_code"
    t.string   "district_code"
    t.text     "note"
    t.boolean  "is_active",                   :default => true
    t.integer  "order_by"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "deliver_regions", ["city_code"], :name => "index_deliver_regions_on_city_code"
  add_index "deliver_regions", ["district_code"], :name => "index_deliver_regions_on_district_code"
  add_index "deliver_regions", ["org_id"], :name => "index_deliver_regions_on_org_id"
  add_index "deliver_regions", ["province_code"], :name => "index_deliver_regions_on_province_code"

  create_table "deposits", :force => true do |t|
    t.integer  "org_id"
    t.decimal  "deposit_fee_1", :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "deposit_fee_2", :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "deposit_fee_3", :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "is_active",                                    :default => true
    t.text     "note"
    t.integer  "user_id"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "deposits", ["org_id"], :name => "index_deposits_on_org_id"
  add_index "deposits", ["user_id"], :name => "index_deposits_on_user_id"

  create_table "digitaction", :force => true do |t|
    t.string "digit",  :limit => 45
    t.string "action", :limit => 45
    t.string "remark", :limit => 45
    t.string "name",   :limit => 45
  end

  create_table "distribution_lists", :force => true do |t|
    t.date     "bill_date"
    t.integer  "user_id"
    t.integer  "org_id",                   :null => false
    t.text     "note"
    t.string   "state",      :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "type",       :limit => 60
  end

  add_index "distribution_lists", ["bill_date"], :name => "index_distribution_lists_on_bill_date"
  add_index "distribution_lists", ["org_id"], :name => "index_distribution_lists_on_org_id"
  add_index "distribution_lists", ["state"], :name => "index_distribution_lists_on_state"
  add_index "distribution_lists", ["user_id"], :name => "index_distribution_lists_on_user_id"

  create_table "divide_config_yujius", :force => true do |t|
    t.integer  "org_id",                                                                    :null => false
    t.decimal  "rate_from",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_to",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_inner_transit_from",  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_inner_transit_to",    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_outter_transit_from", :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "is_active",                                               :default => true
    t.datetime "created_at",                                                                :null => false
    t.datetime "updated_at",                                                                :null => false
  end

  add_index "divide_config_yujius", ["org_id"], :name => "index_divide_config_yujius_on_org_id"

  create_table "divide_configs", :force => true do |t|
    t.string   "bill_type",               :limit => 30,                                                 :null => false
    t.integer  "from_org_id"
    t.decimal  "from_org_divide_rate",                  :precision => 10, :scale => 2, :default => 0.0
    t.integer  "transit_org_id"
    t.decimal  "transit_org_divide_rate",               :precision => 10, :scale => 2, :default => 0.0
    t.integer  "summary_org_id"
    t.decimal  "summary_org_divide_rate",               :precision => 10, :scale => 2, :default => 0.0
    t.integer  "other_org_1_id"
    t.decimal  "other_org_1_divide_rate",               :precision => 10, :scale => 2, :default => 0.0
    t.integer  "other_org_2_id"
    t.decimal  "other_org_2_divide_rate",               :precision => 10, :scale => 2, :default => 0.0
    t.integer  "other_org_3_id"
    t.decimal  "other_org_3_divide_rate",               :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                            :null => false
    t.datetime "updated_at",                                                                            :null => false
    t.integer  "to_org_id"
    t.decimal  "to_org_divide_rate",                    :precision => 10, :scale => 2, :default => 0.0
  end

  create_table "divide_list_lines", :force => true do |t|
    t.integer  "divide_list_id",                                                     :null => false
    t.integer  "price_list_line_id",                                                 :null => false
    t.decimal  "load_per_vehicle",   :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  add_index "divide_list_lines", ["divide_list_id"], :name => "index_divide_list_lines_on_divide_list_id"
  add_index "divide_list_lines", ["price_list_line_id"], :name => "index_divide_list_lines_on_price_list_line_id"

  create_table "divide_lists", :force => true do |t|
    t.integer  "org_id",                                                                 :null => false
    t.boolean  "is_active",                                            :default => true
    t.decimal  "distance_from_summary", :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_per_mile",        :precision => 15, :scale => 2, :default => 0.0
    t.text     "note"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
  end

  add_index "divide_lists", ["org_id"], :name => "index_divide_lists_on_org_id"

  create_table "divide_rpt_yujius", :force => true do |t|
    t.integer  "org_id",                                                                                                :null => false
    t.string   "mth",                                     :limit => 6,                                                  :null => false
    t.integer  "user_id",                                                                                               :null => false
    t.date     "bill_date",                                                                                             :null => false
    t.decimal  "carrying_fee_from",                                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_carrying_fee_from",                                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "divide_carrying_fee_from",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee_to",                                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_carrying_fee_to",                                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "divide_carrying_fee_to",                                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "inner_transit_carrying_fee_from",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_inner_transit_carrying_fee_from",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "divide_inner_transit_carrying_fee_from",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "inner_transit_carrying_fee_to",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_inner_transit_carrying_fee_to",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "divide_inner_transit_carrying_fee_to",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "outter_transit_carrying_fee_from",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "rate_outter_transit_carrying_fee_from",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "divide_outter_transit_carrying_fee_from",               :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_1",                        :limit => 60
    t.decimal  "plus_fee_1",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_2",                        :limit => 60
    t.decimal  "plus_fee_2",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_3",                        :limit => 60
    t.decimal  "plus_fee_3",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_4",                        :limit => 60
    t.decimal  "plus_fee_4",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_5",                        :limit => 60
    t.decimal  "plus_fee_5",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_6",                        :limit => 60
    t.decimal  "plus_fee_6",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_7",                        :limit => 60
    t.decimal  "plus_fee_7",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_8",                        :limit => 60
    t.decimal  "plus_fee_8",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_9",                        :limit => 60
    t.decimal  "plus_fee_9",                                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "plus_item_name_10",                       :limit => 60
    t.decimal  "plus_fee_10",                                           :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_1",                      :limit => 60
    t.decimal  "deduct_fee_1",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_2",                      :limit => 60
    t.decimal  "deduct_fee_2",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_3",                      :limit => 60
    t.decimal  "deduct_fee_3",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_4",                      :limit => 60
    t.decimal  "deduct_fee_4",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_5",                      :limit => 60
    t.decimal  "deduct_fee_5",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_6",                      :limit => 60
    t.decimal  "deduct_fee_6",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_7",                      :limit => 60
    t.decimal  "deduct_fee_7",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_8",                      :limit => 60
    t.decimal  "deduct_fee_8",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_9",                      :limit => 60
    t.decimal  "deduct_fee_9",                                          :precision => 15, :scale => 2, :default => 0.0
    t.string   "deduct_item_name_10",                     :limit => 60
    t.decimal  "deduct_fee_10",                                         :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_1",                :limit => 60
    t.decimal  "other_deduct_fee_1",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_2",                :limit => 60
    t.decimal  "other_deduct_fee_2",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_3",                :limit => 60
    t.decimal  "other_deduct_fee_3",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_4",                :limit => 60
    t.decimal  "other_deduct_fee_4",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_5",                :limit => 60
    t.decimal  "other_deduct_fee_5",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_6",                :limit => 60
    t.decimal  "other_deduct_fee_6",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_7",                :limit => 60
    t.decimal  "other_deduct_fee_7",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_8",                :limit => 60
    t.decimal  "other_deduct_fee_8",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_9",                :limit => 60
    t.decimal  "other_deduct_fee_9",                                    :precision => 15, :scale => 2, :default => 0.0
    t.string   "other_deduct_item_name_10",               :limit => 60
    t.decimal  "other_deduct_fee_10",                                   :precision => 15, :scale => 2, :default => 0.0
    t.text     "note"
    t.string   "state",                                   :limit => 30
    t.datetime "confirm_datetime"
    t.integer  "confirm_user_id"
    t.datetime "created_at",                                                                                            :null => false
    t.datetime "updated_at",                                                                                            :null => false
  end

  add_index "divide_rpt_yujius", ["org_id"], :name => "index_divide_rpt_yujius_on_org_id"
  add_index "divide_rpt_yujius", ["user_id"], :name => "index_divide_rpt_yujius_on_user_id"

  create_table "fee_units", :force => true do |t|
    t.string   "name",          :limit => 60,                                                  :null => false
    t.string   "unit_simp",     :limit => 20
    t.boolean  "is_active",                                                  :default => true
    t.integer  "order_by"
    t.text     "note"
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.decimal  "default_price",               :precision => 15, :scale => 2
    t.integer  "price_type"
  end

  create_table "from_short_fee_infos", :force => true do |t|
    t.date     "bill_date"
    t.integer  "user_id"
    t.integer  "from_org_id",                                      :null => false
    t.integer  "to_org_id",                                        :null => false
    t.string   "state",         :limit => 60, :default => "draft", :null => false
    t.text     "note"
    t.integer  "audit_user_id"
    t.datetime "audit_date"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "from_short_fee_infos", ["user_id"], :name => "index_from_short_fee_infos_on_user_id"

  create_table "from_short_fee_lines", :force => true do |t|
    t.integer  "from_short_fee_info_id", :null => false
    t.integer  "carrying_bill_id",       :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "from_short_fee_lines", ["carrying_bill_id"], :name => "index_from_short_fee_lines_on_carrying_bill_id"
  add_index "from_short_fee_lines", ["from_short_fee_info_id"], :name => "index_from_short_fee_lines_on_from_short_fee_info_id"

  create_table "gerror_authorizes", :force => true do |t|
    t.date     "bill_date",      :null => false
    t.integer  "user_id"
    t.integer  "goods_error_id", :null => false
    t.text     "note"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "gexception_authorize_infos", :force => true do |t|
    t.date     "bill_date",                                                                        :null => false
    t.text     "note"
    t.string   "op_type",            :limit => 20,                                                 :null => false
    t.decimal  "compensation_fee",                 :precision => 10, :scale => 2, :default => 0.0
    t.integer  "user_id"
    t.integer  "goods_exception_id"
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
  end

  add_index "gexception_authorize_infos", ["bill_date"], :name => "index_gexception_authorize_infos_on_bill_date"
  add_index "gexception_authorize_infos", ["goods_exception_id"], :name => "index_gexception_authorize_infos_on_goods_exception_id"
  add_index "gexception_authorize_infos", ["op_type"], :name => "index_gexception_authorize_infos_on_op_type"
  add_index "gexception_authorize_infos", ["user_id"], :name => "index_gexception_authorize_infos_on_user_id"

  create_table "goods_cat_fee_config_lines", :force => true do |t|
    t.decimal  "bottom_price",            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "unit_price",              :precision => 15, :scale => 2, :default => 0.0
    t.integer  "goods_cat_fee_config_id",                                                 :null => false
    t.integer  "goods_cat_id",                                                            :null => false
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
  end

  add_index "goods_cat_fee_config_lines", ["goods_cat_fee_config_id"], :name => "index_goods_cat_fee_config_lines_on_goods_cat_fee_config_id"
  add_index "goods_cat_fee_config_lines", ["goods_cat_id"], :name => "index_goods_cat_fee_config_lines_on_goods_cat_id"

  create_table "goods_cat_fee_configs", :force => true do |t|
    t.integer  "from_org_id",                   :null => false
    t.integer  "to_org_id",                     :null => false
    t.boolean  "is_active",   :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "goods_cat_fee_configs", ["from_org_id"], :name => "index_goods_cat_fee_configs_on_from_org_id"
  add_index "goods_cat_fee_configs", ["is_active"], :name => "index_goods_cat_fee_configs_on_is_active"
  add_index "goods_cat_fee_configs", ["to_org_id"], :name => "index_goods_cat_fee_configs_on_to_org_id"

  create_table "goods_cat_promotions", :force => true do |t|
    t.integer  "goods_cat_id",                                                    :null => false
    t.decimal  "from_fee",       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_fee",         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "promotion_rate", :precision => 15, :scale => 3, :default => 0.0
    t.boolean  "is_active",                                     :default => true
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  add_index "goods_cat_promotions", ["goods_cat_id"], :name => "index_goods_cat_promotions_on_goods_cat_id"

  create_table "goods_cats", :force => true do |t|
    t.string   "name",          :limit => 60,                                                  :null => false
    t.integer  "parent_id"
    t.integer  "order_by",                                                   :default => 0
    t.boolean  "is_active",                                                  :default => true
    t.string   "easy_code",     :limit => 60
    t.string   "note"
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.decimal  "default_price",               :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "bottom_price",                :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "goods_cats", ["easy_code"], :name => "index_goods_cats_on_easy_code"
  add_index "goods_cats", ["is_active"], :name => "index_goods_cats_on_is_active"
  add_index "goods_cats", ["order_by"], :name => "index_goods_cats_on_order_by"
  add_index "goods_cats", ["parent_id"], :name => "index_goods_cats_on_parent_id"

  create_table "goods_errors", :force => true do |t|
    t.integer  "carrying_bill_id"
    t.integer  "org_id",                                        :null => false
    t.integer  "user_id"
    t.date     "bill_date",                                     :null => false
    t.string   "except_type",      :limit => 10,                :null => false
    t.integer  "except_num",                     :default => 1
    t.text     "note"
    t.string   "state",            :limit => 20,                :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "op_org_id"
  end

  create_table "goods_exception_identifies", :force => true do |t|
    t.date     "bill_date",                                                          :null => false
    t.text     "note"
    t.integer  "goods_exception_id",                                                 :null => false
    t.integer  "user_id"
    t.decimal  "from_org_fee",       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_org_fee",         :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.decimal  "driver_fee",         :precision => 15, :scale => 2, :default => 0.0
  end

  add_index "goods_exception_identifies", ["bill_date"], :name => "index_goods_exception_identifies_on_bill_date"
  add_index "goods_exception_identifies", ["user_id"], :name => "index_goods_exception_identifies_on_user_id"

  create_table "goods_exceptions", :force => true do |t|
    t.integer  "org_id",                                          :null => false
    t.integer  "carrying_bill_id"
    t.string   "exception_type",     :limit => 20
    t.date     "bill_date",                                       :null => false
    t.integer  "user_id"
    t.string   "state",              :limit => 20
    t.integer  "except_num",                       :default => 1
    t.text     "note"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "op_org_id"
    t.date     "posted_date"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "goods_exceptions", ["bill_date"], :name => "index_goods_exceptions_on_bill_date"
  add_index "goods_exceptions", ["carrying_bill_id"], :name => "index_goods_exceptions_on_carrying_bill_id"
  add_index "goods_exceptions", ["exception_type"], :name => "index_goods_exceptions_on_exception_type"
  add_index "goods_exceptions", ["org_id"], :name => "index_goods_exceptions_on_org_id"
  add_index "goods_exceptions", ["state"], :name => "index_goods_exceptions_on_state"
  add_index "goods_exceptions", ["user_id"], :name => "index_goods_exceptions_on_user_id"

  create_table "goods_fee_settlement_lists", :force => true do |t|
    t.date     "bill_date",                                                                         :null => false
    t.integer  "org_id",                                                                            :null => false
    t.integer  "user_id"
    t.string   "note"
    t.integer  "post_info_id",                                                                      :null => false
    t.decimal  "amount_fee",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "amount_goods_fee",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "amount_hand_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "amount_k_carrying_fee",            :precision => 15, :scale => 2, :default => 0.0
    t.integer  "amount_bills",                                                    :default => 0
    t.string   "state",                                                           :default => "DR", :null => false
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.decimal  "amount_k_insured_fee",             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "amount_k_from_short_carrying_fee", :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "amount_k_to_short_carrying_fee",   :precision => 15, :scale => 2, :default => 0.0
  end

  create_table "goods_nos", :force => true do |t|
    t.integer  "from_org_id",                :null => false
    t.integer  "to_org_id",                  :null => false
    t.date     "gen_date",                   :null => false
    t.integer  "bill_count",  :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "il_configs", :force => true do |t|
    t.string   "key",        :limit => 60, :null => false
    t.string   "title",      :limit => 60
    t.string   "value",      :limit => 60, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "il_configs", ["key"], :name => "index_il_configs_on_key"

  create_table "in_stock_bill_lines", :force => true do |t|
    t.integer  "in_stock_bill_id", :null => false
    t.integer  "carrying_bill_id", :null => false
    t.text     "note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "in_stock_bill_lines", ["carrying_bill_id"], :name => "index_in_stock_bill_lines_on_carrying_bill_id"
  add_index "in_stock_bill_lines", ["in_stock_bill_id"], :name => "index_in_stock_bill_lines_on_in_stock_bill_id"

  create_table "in_stock_bills", :force => true do |t|
    t.date     "bill_date",                       :null => false
    t.integer  "org_id",                          :null => false
    t.text     "note"
    t.integer  "user_id"
    t.string   "state",      :default => "draft", :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "op_org_id",                       :null => false
  end

  create_table "inventory_ins", :force => true do |t|
    t.integer  "carrying_bill_id",                                                 :null => false
    t.integer  "org_id",                                                           :null => false
    t.decimal  "sum_qty",          :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  add_index "inventory_ins", ["carrying_bill_id"], :name => "index_inventory_ins_on_carrying_bill_id"
  add_index "inventory_ins", ["org_id"], :name => "index_inventory_ins_on_org_id"

  create_table "inventory_move_ins", :id => false, :force => true do |t|
    t.integer "carrying_bill_id",                                :null => false
    t.integer "to_org_id",                                       :null => false
    t.decimal "qty",              :precision => 32, :scale => 2
  end

  create_table "inventory_move_outs", :id => false, :force => true do |t|
    t.integer "carrying_bill_id",                                :null => false
    t.integer "from_org_id",                                     :null => false
    t.decimal "qty",              :precision => 32, :scale => 2
  end

  create_table "inventory_moves", :force => true do |t|
    t.integer  "inventory_id"
    t.integer  "carrying_bill_id",                                                                    :null => false
    t.integer  "from_org_id",                                                                         :null => false
    t.integer  "to_org_id",                                                                           :null => false
    t.datetime "move_datetime",                                                                       :null => false
    t.decimal  "qty",                            :precision => 10, :scale => 2, :default => 0.0,      :null => false
    t.string   "state",            :limit => 60,                                :default => "billed", :null => false
  end

  add_index "inventory_moves", ["carrying_bill_id"], :name => "index_inventory_moves_on_carrying_bill_id"
  add_index "inventory_moves", ["from_org_id"], :name => "index_inventory_moves_on_from_org_id"
  add_index "inventory_moves", ["inventory_id"], :name => "index_inventory_moves_on_inventory_id"
  add_index "inventory_moves", ["state"], :name => "index_inventory_moves_on_state"
  add_index "inventory_moves", ["to_org_id"], :name => "index_inventory_moves_on_to_org_id"

  create_table "inventory_outs", :force => true do |t|
    t.integer  "carrying_bill_id",                                                 :null => false
    t.integer  "org_id",                                                           :null => false
    t.decimal  "sum_qty",          :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  add_index "inventory_outs", ["carrying_bill_id"], :name => "index_inventory_outs_on_carrying_bill_id"
  add_index "inventory_outs", ["org_id"], :name => "index_inventory_outs_on_org_id"

  create_table "journals", :force => true do |t|
    t.integer  "org_id",                                                                                  :null => false
    t.date     "bill_date",                                                                               :null => false
    t.integer  "user_id"
    t.decimal  "settled_no_rebate_fee",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "deliveried_no_settled_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.string   "input_name_1",              :limit => 20
    t.decimal  "input_fee_1",                             :precision => 15, :scale => 2, :default => 0.0
    t.string   "input_name_2",              :limit => 20
    t.decimal  "input_fee_2",                             :precision => 15, :scale => 2, :default => 0.0
    t.string   "input_name_3",              :limit => 20
    t.decimal  "input_fee_3",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cash",                                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "deposits",                                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "short_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "other_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "black_bills",                                                            :default => 0
    t.integer  "red_bills",                                                              :default => 0
    t.integer  "yellow_bills",                                                           :default => 0
    t.integer  "green_bills",                                                            :default => 0
    t.integer  "blue_bills",                                                             :default => 0
    t.integer  "white_bills",                                                            :default => 0
    t.decimal  "current_debt",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "current_debt_2_3",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "current_debt_4_5",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "current_debt_ge_6",                       :precision => 15, :scale => 2, :default => 0.0
    t.text     "note"
    t.datetime "created_at",                                                                              :null => false
    t.datetime "updated_at",                                                                              :null => false
  end

  add_index "journals", ["bill_date"], :name => "index_journals_on_bill_date"
  add_index "journals", ["org_id"], :name => "index_journals_on_org_id"
  add_index "journals", ["user_id"], :name => "index_journals_on_user_id"

  create_table "lhma_2021_06_09_06_17_04_992_carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                          :null => false
    t.string   "bill_no",                          :limit => 30,                                                     :null => false
    t.string   "goods_no",                         :limit => 30,                                                     :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                     :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                     :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                 :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                   :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                   :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                      :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                        :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                          :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                     :null => false
    t.integer  "goods_num",                                                                     :default => 1
    t.decimal  "goods_weight",                                   :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                   :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 20
    t.string   "state",                            :limit => 20
    t.boolean  "completed",                                                                     :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                         :null => false
    t.datetime "updated_at",                                                                                         :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                     :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                 :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                :default => "draft"
    t.integer  "print_counter",                                                                 :default => 0,       :null => false
  end

  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "lhma_2021_06_09_06_17_04_992_carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "lhma_2021_06_09_06_17_19_579_carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                           :null => false
    t.string   "bill_no",                          :limit => 30,                                                      :null => false
    t.string   "goods_no",                         :limit => 30,                                                      :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                      :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                      :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                  :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                    :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                      :null => false
    t.integer  "goods_num",                                                                      :default => 1
    t.decimal  "goods_weight",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                    :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 100
    t.string   "state",                            :limit => 20
    t.boolean  "completed",                                                                      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                          :null => false
    t.datetime "updated_at",                                                                                          :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                 :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                 :default => "draft"
    t.integer  "print_counter",                                                                  :default => 0,       :null => false
    t.integer  "goods_cat_id"
    t.decimal  "unit_price",                                      :precision => 15, :scale => 3, :default => 0.0
  end

  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["goods_cat_id"], :name => "index_carrying_bills_on_goods_cat_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "lhma_2021_06_09_06_17_19_579_carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "lhma_2021_06_09_06_17_27_610_carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                           :null => false
    t.string   "bill_no",                          :limit => 30,                                                      :null => false
    t.string   "goods_no",                         :limit => 30,                                                      :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                      :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                      :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                  :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                    :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                      :null => false
    t.integer  "goods_num",                                                                      :default => 1
    t.decimal  "goods_weight",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                    :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 100
    t.string   "state",                            :limit => 60
    t.boolean  "completed",                                                                      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                          :null => false
    t.datetime "updated_at",                                                                                          :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                 :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                 :default => "draft"
    t.integer  "print_counter",                                                                  :default => 0,       :null => false
    t.integer  "goods_cat_id"
    t.decimal  "unit_price",                                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "carrying_fee_1st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee_2st",                                :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["goods_cat_id"], :name => "index_carrying_bills_on_goods_cat_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "lhma_2021_06_09_06_17_27_610_carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "lhma_2021_06_09_06_17_32_020_carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                           :null => false
    t.string   "bill_no",                          :limit => 30,                                                      :null => false
    t.string   "goods_no",                         :limit => 30,                                                      :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                      :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                      :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                  :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                    :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                      :null => false
    t.integer  "goods_num",                                                                      :default => 1
    t.decimal  "goods_weight",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                    :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 100
    t.string   "state",                            :limit => 60
    t.boolean  "completed",                                                                      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                          :null => false
    t.datetime "updated_at",                                                                                          :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                 :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                 :default => "draft"
    t.integer  "print_counter",                                                                  :default => 0,       :null => false
    t.integer  "goods_cat_id"
    t.decimal  "unit_price",                                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "carrying_fee_1st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee_2st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "adjust_carrying_fee",                             :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["goods_cat_id"], :name => "index_carrying_bills_on_goods_cat_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "lhma_2021_06_09_06_17_32_020_carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "lhma_2021_06_09_06_17_40_099_carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                           :null => false
    t.string   "bill_no",                          :limit => 30,                                                      :null => false
    t.string   "goods_no",                         :limit => 30,                                                      :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                      :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                      :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                  :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                    :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                      :null => false
    t.integer  "goods_num",                                                                      :default => 1
    t.decimal  "goods_weight",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                    :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 100
    t.string   "state",                            :limit => 60
    t.boolean  "completed",                                                                      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                          :null => false
    t.datetime "updated_at",                                                                                          :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                 :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                 :default => "draft"
    t.integer  "print_counter",                                                                  :default => 0,       :null => false
    t.integer  "goods_cat_id"
    t.decimal  "unit_price",                                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "carrying_fee_1st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee_2st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "adjust_carrying_fee",                             :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "manage_fee",                                      :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["goods_cat_id"], :name => "index_carrying_bills_on_goods_cat_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "lhma_2021_06_09_06_17_40_099_carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "lhma_2021_06_09_06_17_46_257_carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                           :null => false
    t.string   "bill_no",                          :limit => 30,                                                      :null => false
    t.string   "goods_no",                         :limit => 30,                                                      :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                      :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                      :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                  :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                    :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                      :null => false
    t.integer  "goods_num",                                                                      :default => 1
    t.decimal  "goods_weight",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                    :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 100
    t.string   "state",                            :limit => 60
    t.boolean  "completed",                                                                      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                          :null => false
    t.datetime "updated_at",                                                                                          :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                 :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                 :default => "draft"
    t.integer  "print_counter",                                                                  :default => 0,       :null => false
    t.integer  "goods_cat_id"
    t.decimal  "unit_price",                                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "carrying_fee_1st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee_2st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "adjust_carrying_fee",                             :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "manage_fee",                                      :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["created_at"], :name => "index_carrying_bills_on_created_at"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["distribution_list_id"], :name => "index_carrying_bills_on_distribution_list_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["goods_cat_id"], :name => "index_carrying_bills_on_goods_cat_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["updated_at"], :name => "index_carrying_bills_on_updated_at"
  add_index "lhma_2021_06_09_06_17_46_257_carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "lhma_2021_06_09_06_17_50_770_carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                           :null => false
    t.string   "bill_no",                          :limit => 30,                                                      :null => false
    t.string   "goods_no",                         :limit => 30,                                                      :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                      :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                      :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.decimal  "insured_amount",                                  :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                    :precision => 10, :scale => 5, :default => 0.0
    t.decimal  "insured_fee",                                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                      :null => false
    t.integer  "goods_num",                                                                      :default => 1
    t.decimal  "goods_weight",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                    :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 100
    t.string   "state",                            :limit => 60
    t.boolean  "completed",                                                                      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                                                                                          :null => false
    t.datetime "updated_at",                                                                                          :null => false
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.decimal  "original_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "package",                          :limit => 30
    t.string   "transit_bill_no",                  :limit => 20
    t.string   "transit_to_phone",                 :limit => 20
    t.integer  "area_id"
    t.string   "to_short_fee_state",               :limit => 20,                                 :default => "draft"
    t.string   "from_short_fee_state",             :limit => 20,                                 :default => "draft"
    t.integer  "print_counter",                                                                  :default => 0,       :null => false
    t.integer  "goods_cat_id"
    t.decimal  "unit_price",                                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "carrying_fee_1st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee_2st",                                :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "adjust_carrying_fee",                             :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "manage_fee",                                      :precision => 10, :scale => 2, :default => 0.0
    t.integer  "th_bill_print_count",                                                            :default => 0
  end

  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["area_id"], :name => "index_carrying_bills_on_area_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["created_at"], :name => "index_carrying_bills_on_created_at"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["distribution_list_id"], :name => "index_carrying_bills_on_distribution_list_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["from_short_fee_state"], :name => "index_carrying_bills_on_from_short_fee_state"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["goods_cat_id"], :name => "index_carrying_bills_on_goods_cat_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["print_counter"], :name => "index_carrying_bills_on_print_counter"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["to_short_fee_state"], :name => "index_carrying_bills_on_to_short_fee_state"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["transit_bill_no"], :name => "index_carrying_bills_on_transit_bill_no"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["updated_at"], :name => "index_carrying_bills_on_updated_at"
  add_index "lhma_2021_06_09_06_17_50_770_carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "lhma_2021_06_09_06_18_32_282_bill_association_objects", :force => true do |t|
    t.integer  "from_customer_id"
    t.integer  "to_customer_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "customerable_id",                                    :null => false
    t.string   "customerable_type", :limit => 60,                    :null => false
    t.boolean  "is_deliver",                      :default => false
    t.boolean  "is_urgent",                       :default => false
    t.boolean  "is_receipt",                      :default => false
    t.boolean  "is_list",                         :default => false
  end

  add_index "lhma_2021_06_09_06_18_32_282_bill_association_objects", ["customerable_id"], :name => "index_bill_association_objects_on_customerable_id"
  add_index "lhma_2021_06_09_06_18_32_282_bill_association_objects", ["customerable_type"], :name => "index_bill_association_objects_on_customerable_type"
  add_index "lhma_2021_06_09_06_18_32_282_bill_association_objects", ["from_customer_id"], :name => "index_bill_association_objects_on_from_customer_id"
  add_index "lhma_2021_06_09_06_18_32_282_bill_association_objects", ["to_customer_id"], :name => "index_bill_association_objects_on_to_customer_id"

  create_table "lhma_2021_06_09_06_18_33_973_bill_lines", :force => true do |t|
    t.integer  "carrying_bill_id",                                                 :null => false
    t.integer  "goods_cat_id"
    t.integer  "qty",                                             :default => 1
    t.string   "package"
    t.decimal  "volume",           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "weight",           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price",            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "amt",              :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.integer  "fee_unit_id"
  end

  add_index "lhma_2021_06_09_06_18_33_973_bill_lines", ["carrying_bill_id"], :name => "index_bill_lines_on_carrying_bill_id"
  add_index "lhma_2021_06_09_06_18_33_973_bill_lines", ["goods_cat_id"], :name => "index_bill_lines_on_goods_cat_id"

  create_table "load_list_with_barcode_lines", :force => true do |t|
    t.integer  "load_list_with_barcode_id",                                      :null => false
    t.string   "barcode",                    :limit => 30,                       :null => false
    t.string   "state",                                     :default => "draft", :null => false
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.integer  "manual_set_all",                            :default => 0
    t.string   "note",                       :limit => 300
    t.string   "goods_photo_1_file_name"
    t.string   "goods_photo_1_content_type"
    t.integer  "goods_photo_1_file_size"
    t.datetime "goods_photo_1_updated_at"
    t.string   "goods_photo_2_file_name"
    t.string   "goods_photo_2_content_type"
    t.integer  "goods_photo_2_file_size"
    t.datetime "goods_photo_2_updated_at"
    t.integer  "carrying_bill_id"
  end

  add_index "load_list_with_barcode_lines", ["load_list_with_barcode_id"], :name => "index_load_list_with_barcode_lines_on_load_list_with_barcode_id"

  create_table "load_list_with_barcodes", :force => true do |t|
    t.integer  "to_org_id",                                          :null => false
    t.string   "bill_no",         :limit => 20
    t.date     "bill_date",                                          :null => false
    t.text     "note"
    t.integer  "user_id"
    t.string   "state",                         :default => "draft", :null => false
    t.date     "confirm_date"
    t.integer  "confirmer_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "from_org_id",                                        :null => false
    t.integer  "sum_goods_count",               :default => 0
    t.integer  "sum_bills_count",               :default => 0
    t.string   "driver",          :limit => 30
    t.string   "vehicle_no",      :limit => 30
    t.string   "mobile",          :limit => 30
    t.string   "op_type",         :limit => 60
  end

  add_index "load_list_with_barcodes", ["from_org_id"], :name => "index_load_list_with_barcodes_on_from_org_id"

  create_table "load_lists", :force => true do |t|
    t.date     "bill_date"
    t.string   "bill_no",                  :limit => 20
    t.integer  "from_org_id",                            :null => false
    t.integer  "to_org_id",                              :null => false
    t.string   "state",                    :limit => 20
    t.text     "note"
    t.string   "driver",                   :limit => 20
    t.string   "vehicle_no",               :limit => 20
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "user_id"
    t.date     "reached_date"
    t.integer  "transit_org_id"
    t.string   "type",                     :limit => 60
    t.integer  "reached_user_id"
    t.datetime "reached_datetime"
    t.datetime "transit_reached_datetime"
    t.integer  "transit_reached_user_id"
    t.datetime "transit_ship_datetime"
    t.integer  "transit_ship_user_id"
  end

  add_index "load_lists", ["bill_date"], :name => "index_load_lists_on_bill_date"
  add_index "load_lists", ["bill_no"], :name => "index_load_lists_on_bill_no"
  add_index "load_lists", ["from_org_id"], :name => "index_load_lists_on_from_org_id"
  add_index "load_lists", ["state"], :name => "index_load_lists_on_state"
  add_index "load_lists", ["to_org_id"], :name => "index_load_lists_on_to_org_id"
  add_index "load_lists", ["user_id"], :name => "index_load_lists_on_user_id"

  create_table "message_histories", :force => true do |t|
    t.integer  "message_id",                :null => false
    t.integer  "user_id",                   :null => false
    t.integer  "view_count", :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "message_histories", ["message_id"], :name => "index_message_histories_on_message_id"
  add_index "message_histories", ["user_id"], :name => "index_message_histories_on_user_id"

  create_table "message_users", :force => true do |t|
    t.integer  "message_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "viewed",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "message_users", ["message_id"], :name => "index_message_users_on_message_id"
  add_index "message_users", ["user_id"], :name => "index_message_users_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "title",               :limit => 60,                    :null => false
    t.text     "body"
    t.string   "type",                :limit => 30
    t.boolean  "is_secure",                         :default => false
    t.string   "state",               :limit => 30
    t.integer  "org_id"
    t.string   "org_name"
    t.boolean  "is_active",                         :default => true
    t.integer  "user_id"
    t.datetime "publish_date"
    t.integer  "publisher_id"
    t.string   "publisher_name"
    t.string   "doc_no"
    t.boolean  "violation_generated",               :default => false
    t.boolean  "up_state"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.string   "attach_file_size"
    t.datetime "attach_updated_at"
    t.string   "attach_url"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  create_table "notice_lines", :force => true do |t|
    t.integer  "notice_id",                                               :null => false
    t.integer  "carrying_bill_id",                                        :null => false
    t.string   "from_customer_phone", :limit => 60,                       :null => false
    t.string   "calling_text",        :limit => 200,                      :null => false
    t.string   "sms_text",            :limit => 200
    t.string   "calling_state",       :limit => 20,  :default => "draft", :null => false
    t.string   "sms_state",           :limit => 20,  :default => "draft", :null => false
    t.integer  "calling_count",                      :default => 0
    t.integer  "sms_count",                          :default => 0
    t.datetime "last_calling_time"
    t.datetime "last_sms_time"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  create_table "notices", :force => true do |t|
    t.integer  "org_id",                                          :null => false
    t.integer  "load_list_id"
    t.integer  "user_id"
    t.date     "bill_date"
    t.string   "state",        :limit => 20, :default => "draft", :null => false
    t.text     "note"
    t.string   "bymanual",     :limit => 2
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "notifies", :force => true do |t|
    t.text     "notify_text"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "org_load_orgs", :force => true do |t|
    t.integer  "org_load_id"
    t.integer  "org_id"
    t.boolean  "is_select",   :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "org_load_orgs", ["org_id"], :name => "index_org_load_orgs_on_org_id"
  add_index "org_load_orgs", ["org_load_id"], :name => "index_org_load_orgs_on_org_load_id"

  create_table "org_permits", :force => true do |t|
    t.integer  "org_id",                           :null => false
    t.integer  "permit_org_id",                    :null => false
    t.boolean  "is_select",     :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "org_permits", ["org_id"], :name => "index_org_permits_on_org_id"
  add_index "org_permits", ["permit_org_id"], :name => "index_org_permits_on_permit_org_id"

  create_table "org_sorting_orgs", :force => true do |t|
    t.integer  "org_sorting_id"
    t.integer  "org_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "is_select",      :default => false
  end

  add_index "org_sorting_orgs", ["org_id"], :name => "index_org_sorting_orgs_on_org_id"
  add_index "org_sorting_orgs", ["org_sorting_id"], :name => "index_org_sorting_orgs_on_org_sorting_id"

  create_table "orgs", :force => true do |t|
    t.string   "name",                                  :limit => 60,                                                       :null => false
    t.string   "simp_name",                             :limit => 20
    t.integer  "parent_id"
    t.string   "phone",                                 :limit => 60
    t.boolean  "is_active",                                                                          :default => true,      :null => false
    t.string   "manager",                               :limit => 20
    t.string   "location",                              :limit => 60
    t.string   "code",                                  :limit => 20
    t.string   "lock_input_time",                       :limit => 20
    t.string   "type",                                  :limit => 20
    t.datetime "created_at",                                                                                                :null => false
    t.datetime "updated_at",                                                                                                :null => false
    t.string   "py",                                    :limit => 20
    t.boolean  "is_yard",                                                                            :default => false
    t.integer  "order_by",                                                                           :default => 0
    t.boolean  "is_summary",                                                                         :default => false
    t.decimal  "carrying_fee_gte_on_insured_fee",                     :precision => 15, :scale => 2
    t.boolean  "is_visible",                                                                         :default => true,      :null => false
    t.boolean  "auto_generate_to_short_carrying_fee",                                                :default => false
    t.decimal  "agtscf_rate",                                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "fixed_to_short_carrying_fee",                         :precision => 10, :scale => 2, :default => 0.0
    t.text     "note"
    t.decimal  "limit_goods_fee",                                     :precision => 10, :scale => 2, :default => 9999999.0
    t.boolean  "auto_generate_from_short_carrying_fee",                                              :default => false
    t.decimal  "agfscf_rate",                                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "fixed_from_short_carrying_fee",                       :precision => 15, :scale => 2, :default => 0.0
    t.integer  "yard_id"
    t.boolean  "is_allocation",                                                                      :default => false
    t.decimal  "fixed_insured_fee",                                   :precision => 15, :scale => 2, :default => 0.0
  end

  add_index "orgs", ["code"], :name => "index_orgs_on_code"
  add_index "orgs", ["name"], :name => "index_orgs_on_name"
  add_index "orgs", ["parent_id"], :name => "index_orgs_on_parent_id"
  add_index "orgs", ["simp_name"], :name => "index_orgs_on_simp_name"
  add_index "orgs", ["type"], :name => "index_orgs_on_type"

  create_table "pay_infos", :force => true do |t|
    t.integer  "org_id"
    t.integer  "user_id"
    t.string   "customer_name", :limit => 30, :null => false
    t.string   "id_number",     :limit => 30
    t.string   "state",         :limit => 20
    t.text     "note"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.date     "bill_date",                   :null => false
    t.string   "type",          :limit => 60
    t.string   "account_name",  :limit => 20
    t.string   "account_no",    :limit => 30
    t.integer  "bank_id"
    t.string   "mobile",        :limit => 11
  end

  add_index "pay_infos", ["bill_date"], :name => "index_pay_infos_on_bill_date"
  add_index "pay_infos", ["org_id"], :name => "index_pay_infos_on_org_id"
  add_index "pay_infos", ["state"], :name => "index_pay_infos_on_state"
  add_index "pay_infos", ["type"], :name => "index_pay_infos_on_type"
  add_index "pay_infos", ["user_id"], :name => "index_pay_infos_on_user_id"

  create_table "payment_lists", :force => true do |t|
    t.integer  "bank_id"
    t.integer  "org_id"
    t.integer  "user_id"
    t.string   "state",      :limit => 20
    t.string   "type",       :limit => 60
    t.text     "note"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.date     "bill_date",                :null => false
  end

  add_index "payment_lists", ["bank_id"], :name => "index_payment_lists_on_bank_id"
  add_index "payment_lists", ["bill_date"], :name => "index_payment_lists_on_bill_date"
  add_index "payment_lists", ["org_id"], :name => "index_payment_lists_on_org_id"
  add_index "payment_lists", ["state"], :name => "index_payment_lists_on_state"
  add_index "payment_lists", ["type"], :name => "index_payment_lists_on_type"
  add_index "payment_lists", ["user_id"], :name => "index_payment_lists_on_user_id"

  create_table "post_infos", :force => true do |t|
    t.integer  "org_id"
    t.integer  "user_id"
    t.text     "note"
    t.date     "bill_date",                                                                   :null => false
    t.decimal  "amount_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "state",         :limit => 20
    t.datetime "created_at",                                                                  :null => false
    t.datetime "updated_at",                                                                  :null => false
    t.string   "type",          :limit => 60
    t.date     "transfer_date"
  end

  add_index "post_infos", ["bill_date"], :name => "index_post_infos_on_bill_date"
  add_index "post_infos", ["org_id"], :name => "index_post_infos_on_org_id"
  add_index "post_infos", ["state"], :name => "index_post_infos_on_state"
  add_index "post_infos", ["user_id"], :name => "index_post_infos_on_user_id"

  create_table "prepay_entries", :force => true do |t|
    t.integer  "org_id",                                                     :null => false
    t.date     "bill_date",                                                  :null => false
    t.text     "note"
    t.decimal  "debit",      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "credit",     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "balance",    :precision => 15, :scale => 2, :default => 0.0
    t.integer  "entry_type",                                :default => 1
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  add_index "prepay_entries", ["entry_type"], :name => "index_prepay_entries_on_entry_type"
  add_index "prepay_entries", ["org_id", "bill_date"], :name => "index_prepay_entries_on_org_id_and_bill_date"
  add_index "prepay_entries", ["org_id"], :name => "index_prepay_entries_on_org_id"

  create_table "price_list_lines", :force => true do |t|
    t.integer  "price_list_id",                                                  :null => false
    t.integer  "fee_unit_id",                                                    :null => false
    t.decimal  "price",         :precision => 15, :scale => 2, :default => 1.0
    t.decimal  "min_price",     :precision => 15, :scale => 2, :default => 1.0
    t.decimal  "divide_rate",   :precision => 15, :scale => 2, :default => 0.63
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "price_list_lines", ["price_list_id"], :name => "index_price_list_lines_on_price_list_id"

  create_table "price_lists", :force => true do |t|
    t.integer  "org_id",                       :null => false
    t.boolean  "is_active",  :default => true
    t.text     "note"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "price_lists", ["org_id"], :name => "index_price_lists_on_org_id"

  create_table "price_tables", :force => true do |t|
    t.integer  "to_org_id",                                                                     :null => false
    t.string   "province_code", :limit => 20
    t.string   "city_code",     :limit => 20
    t.string   "district_code", :limit => 20
    t.string   "tag",           :limit => 60
    t.decimal  "price_1",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_2",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_3",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_4",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_5",                     :precision => 15, :scale => 2, :default => 0.0
    t.string   "price_6",       :limit => 60,                                :default => "0.0"
    t.string   "price_7",       :limit => 60,                                :default => "0.0"
    t.decimal  "price_8",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_9",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_10",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_11",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "price_12",                    :precision => 15, :scale => 2, :default => 0.0
    t.integer  "order_by",                                                   :default => 0
    t.text     "note"
    t.datetime "created_at",                                                                    :null => false
    t.datetime "updated_at",                                                                    :null => false
  end

  create_table "refounds", :force => true do |t|
    t.date     "bill_date",                                                                              :null => false
    t.integer  "from_org_id",                                                                            :null => false
    t.integer  "to_org_id",                                                                              :null => false
    t.string   "state",                    :limit => 60
    t.integer  "user_id"
    t.text     "note"
    t.decimal  "sum_goods_fee",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_carrying_fee",                       :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                             :null => false
    t.datetime "updated_at",                                                                             :null => false
    t.decimal  "sum_transit_carrying_fee",               :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "sum_transit_hand_fee",                   :precision => 10, :scale => 2, :default => 0.0
    t.integer  "transit_org_id"
    t.string   "type",                     :limit => 60
  end

  add_index "refounds", ["bill_date"], :name => "index_refounds_on_bill_date"
  add_index "refounds", ["from_org_id"], :name => "index_refounds_on_from_org_id"
  add_index "refounds", ["state"], :name => "index_refounds_on_state"
  add_index "refounds", ["to_org_id"], :name => "index_refounds_on_to_org_id"
  add_index "refounds", ["user_id"], :name => "index_refounds_on_user_id"

  create_table "region_divide_configs", :force => true do |t|
    t.integer  "from_region_id",                                                  :null => false
    t.integer  "to_region_id",                                                    :null => false
    t.decimal  "from_rate",      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_rate",        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "summary_rate",   :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "is_active",                                     :default => true
    t.text     "note"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  add_index "region_divide_configs", ["from_region_id"], :name => "index_region_divide_configs_on_from_region_id"
  add_index "region_divide_configs", ["to_region_id"], :name => "index_region_divide_configs_on_to_region_id"

  create_table "region_orgs", :force => true do |t|
    t.integer  "region_id"
    t.integer  "org_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "region_orgs", ["org_id"], :name => "index_region_orgs_on_org_id"
  add_index "region_orgs", ["region_id"], :name => "index_region_orgs_on_region_id"

  create_table "regions", :force => true do |t|
    t.string   "name",       :limit => 60,                   :null => false
    t.string   "note"
    t.boolean  "is_active",                :default => true
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "remittances", :force => true do |t|
    t.integer  "from_org_id",                                                                                   :null => false
    t.integer  "to_org_id",                                                                                     :null => false
    t.date     "bill_date",                                                                                     :null => false
    t.integer  "user_id"
    t.integer  "refound_id",                                                                                    :null => false
    t.text     "note"
    t.decimal  "should_fee",                                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "act_fee",                                       :precision => 15, :scale => 2, :default => 0.0
    t.string   "state",                           :limit => 20
    t.datetime "created_at",                                                                                    :null => false
    t.datetime "updated_at",                                                                                    :null => false
    t.decimal  "validate_fee",                                  :precision => 15, :scale => 2, :default => 0.0
    t.integer  "validate_user_id"
    t.decimal  "inner_transit_refund_should_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "pos_fee",                                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "quick_fee",                                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "other_fee",                                     :precision => 15, :scale => 2, :default => 0.0
    t.datetime "validate_date"
  end

  add_index "remittances", ["bill_date"], :name => "index_remittances_on_bill_date"
  add_index "remittances", ["from_org_id"], :name => "index_remittances_on_from_org_id"
  add_index "remittances", ["refound_id"], :name => "index_remittances_on_refound_id"
  add_index "remittances", ["state"], :name => "index_remittances_on_state"
  add_index "remittances", ["to_org_id"], :name => "index_remittances_on_to_org_id"
  add_index "remittances", ["user_id"], :name => "index_remittances_on_user_id"

  create_table "role_system_function_operates", :force => true do |t|
    t.integer  "role_id",                                       :null => false
    t.integer  "system_function_operate_id",                    :null => false
    t.boolean  "is_select",                  :default => false, :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "role_system_function_operates", ["is_select"], :name => "index_role_system_function_operates_on_is_select"
  add_index "role_system_function_operates", ["role_id"], :name => "index_role_system_function_operates_on_role_id"
  add_index "role_system_function_operates", ["system_function_operate_id"], :name => "rsfo_sf_operate_idx"

  create_table "role_system_functions", :force => true do |t|
    t.integer  "role_id"
    t.integer  "system_function_id"
    t.boolean  "is_select",          :default => false, :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :limit => 30,                   :null => false
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "roles", ["is_active"], :name => "index_roles_on_is_active"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rpt_from_org_mths", :force => true do |t|
    t.integer  "from_org_id"
    t.string   "mth",                         :limit => 6
    t.string   "pay_type",                    :limit => 20,                                                 :null => false
    t.decimal  "sum_carrying_fee",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_goods_fee",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_insured_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_k_hand_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_manage_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_from_short_carrying_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_to_short_carrying_fee",                 :precision => 15, :scale => 2, :default => 0.0
    t.integer  "sum_goods_num",                                                            :default => 0
    t.integer  "sum_bill_count",                                                           :default => 0
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
    t.integer  "to_org_id"
  end

  create_table "scan_headers", :force => true do |t|
    t.integer  "from_org_id"
    t.integer  "to_org_id"
    t.integer  "user_id"
    t.string   "type",        :limit => 60
    t.date     "bill_date"
    t.text     "note"
    t.string   "state",       :limit => 60, :default => "draft"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "driver_name", :limit => 30
    t.string   "v_no",        :limit => 30
    t.string   "mobile",      :limit => 30
    t.string   "id_no",       :limit => 30
  end

  add_index "scan_headers", ["user_id"], :name => "index_scan_headers_on_user_id"

  create_table "scan_lines", :force => true do |t|
    t.integer  "scan_header_id"
    t.integer  "carrying_bill_id"
    t.integer  "from_org_id"
    t.integer  "to_org_id"
    t.integer  "qty"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.integer  "goods_status_type",               :default => 0
    t.string   "goods_status_note", :limit => 60
    t.integer  "load_list_id"
  end

  add_index "scan_lines", ["carrying_bill_id"], :name => "index_scan_lines_on_carrying_bill_id"
  add_index "scan_lines", ["scan_header_id"], :name => "index_scan_lines_on_scan_header_id"

  create_table "send_list_backs", :force => true do |t|
    t.integer  "org_id",     :null => false
    t.integer  "sender_id",  :null => false
    t.integer  "user_id"
    t.date     "bill_date"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "send_list_backs", ["bill_date"], :name => "index_send_list_backs_on_bill_date"
  add_index "send_list_backs", ["org_id"], :name => "index_send_list_backs_on_org_id"
  add_index "send_list_backs", ["sender_id"], :name => "index_send_list_backs_on_sender_id"
  add_index "send_list_backs", ["user_id"], :name => "index_send_list_backs_on_user_id"

  create_table "send_list_lines", :force => true do |t|
    t.integer  "send_list_id",                    :null => false
    t.integer  "carrying_bill_id",                :null => false
    t.string   "state",             :limit => 20
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "send_list_post_id"
    t.integer  "send_list_back_id"
  end

  add_index "send_list_lines", ["carrying_bill_id"], :name => "index_send_list_lines_on_carrying_bill_id"
  add_index "send_list_lines", ["send_list_back_id"], :name => "index_send_list_lines_on_send_list_back_id"
  add_index "send_list_lines", ["send_list_id"], :name => "index_send_list_lines_on_send_list_id"
  add_index "send_list_lines", ["send_list_post_id"], :name => "index_send_list_lines_on_send_list_post_id"
  add_index "send_list_lines", ["state"], :name => "index_send_list_lines_on_state"

  create_table "send_list_posts", :force => true do |t|
    t.date     "bill_date"
    t.text     "note"
    t.integer  "user_id"
    t.integer  "sender_id",  :null => false
    t.integer  "org_id",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "send_list_posts", ["bill_date"], :name => "index_send_list_posts_on_bill_date"
  add_index "send_list_posts", ["org_id"], :name => "index_send_list_posts_on_org_id"
  add_index "send_list_posts", ["sender_id"], :name => "index_send_list_posts_on_sender_id"
  add_index "send_list_posts", ["user_id"], :name => "index_send_list_posts_on_user_id"

  create_table "send_lists", :force => true do |t|
    t.date     "bill_date",  :null => false
    t.integer  "sender_id",  :null => false
    t.text     "note"
    t.integer  "org_id",     :null => false
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "send_lists", ["bill_date"], :name => "index_send_lists_on_bill_date"
  add_index "send_lists", ["org_id"], :name => "index_send_lists_on_org_id"
  add_index "send_lists", ["sender_id"], :name => "index_send_lists_on_sender_id"
  add_index "send_lists", ["user_id"], :name => "index_send_lists_on_user_id"

  create_table "senders", :force => true do |t|
    t.string   "name",       :limit => 20,                   :null => false
    t.integer  "org_id",                                     :null => false
    t.string   "mobile",     :limit => 20
    t.string   "address",    :limit => 60
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "id_number",  :limit => 20
  end

  add_index "senders", ["is_active"], :name => "index_senders_on_is_active"
  add_index "senders", ["name"], :name => "index_senders_on_name"
  add_index "senders", ["org_id"], :name => "index_senders_on_org_id"

  create_table "settlements", :force => true do |t|
    t.string   "title",                    :limit => 60
    t.integer  "org_id",                                                                                 :null => false
    t.decimal  "sum_goods_fee",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_carrying_fee",                       :precision => 15, :scale => 2, :default => 0.0
    t.integer  "user_id"
    t.text     "note"
    t.string   "state",                    :limit => 20
    t.datetime "created_at",                                                                             :null => false
    t.datetime "updated_at",                                                                             :null => false
    t.date     "bill_date",                                                                              :null => false
    t.decimal  "sum_transit_carrying_fee",               :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "sum_transit_hand_fee",                   :precision => 10, :scale => 2, :default => 0.0
    t.string   "type",                     :limit => 60
  end

  add_index "settlements", ["bill_date"], :name => "index_settlements_on_bill_date"
  add_index "settlements", ["org_id"], :name => "index_settlements_on_org_id"
  add_index "settlements", ["state"], :name => "index_settlements_on_state"
  add_index "settlements", ["user_id"], :name => "index_settlements_on_user_id"

  create_table "short_fee_configs", :force => true do |t|
    t.string   "name",                 :limit => 60,                                                  :null => false
    t.integer  "from_org_id",                                                                         :null => false
    t.integer  "to_org_id",                                                                           :null => false
    t.decimal  "carrying_fee",                       :precision => 15, :scale => 2
    t.string   "operator",             :limit => 20,                                                  :null => false
    t.decimal  "short_fee_rate",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "fixed_short_fee",                    :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "is_active",                                                         :default => true
    t.text     "note"
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.decimal  "from_short_fee_rate",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "fixed_from_short_fee",               :precision => 15, :scale => 2, :default => 0.0
  end

  add_index "short_fee_configs", ["from_org_id"], :name => "index_short_fee_configs_on_from_org_id"
  add_index "short_fee_configs", ["to_org_id"], :name => "index_short_fee_configs_on_to_org_id"

  create_table "short_fee_info_lines", :force => true do |t|
    t.integer  "short_fee_info_id"
    t.integer  "carrying_bill_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "short_fee_infos", :force => true do |t|
    t.date     "bill_date",                                        :null => false
    t.integer  "org_id",                                           :null => false
    t.integer  "user_id"
    t.string   "state",          :limit => 20
    t.text     "note"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "op_org_id"
    t.date     "write_off_date"
    t.string   "fee_type",       :limit => 60, :default => "from", :null => false
  end

  add_index "short_fee_infos", ["bill_date"], :name => "index_short_fee_infos_on_bill_date"
  add_index "short_fee_infos", ["org_id"], :name => "index_short_fee_infos_on_org_id"
  add_index "short_fee_infos", ["state"], :name => "index_short_fee_infos_on_state"
  add_index "short_fee_infos", ["user_id"], :name => "index_short_fee_infos_on_user_id"

  create_table "short_lists", :force => true do |t|
    t.date     "bill_date"
    t.string   "bill_no"
    t.string   "vehicle_no"
    t.string   "driver"
    t.string   "mobile"
    t.integer  "from_org_id",                           :null => false
    t.integer  "to_org_id",                             :null => false
    t.text     "note"
    t.string   "state",            :default => "draft"
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "reached_user_id"
    t.datetime "reached_datetime"
  end

  add_index "short_lists", ["from_org_id"], :name => "index_short_lists_on_from_org_id"
  add_index "short_lists", ["to_org_id"], :name => "index_short_lists_on_to_org_id"
  add_index "short_lists", ["user_id"], :name => "index_short_lists_on_user_id"

  create_table "system_function_groups", :force => true do |t|
    t.string   "name",       :limit => 30,                   :null => false
    t.integer  "order",                    :default => 1
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "system_function_groups", ["is_active"], :name => "index_system_function_groups_on_is_active"

  create_table "system_function_operates", :force => true do |t|
    t.integer  "system_function_id",                                 :null => false
    t.string   "name",               :limit => 30,                   :null => false
    t.text     "function_obj"
    t.integer  "order",                            :default => 1
    t.boolean  "is_active",                        :default => true, :null => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.text     "new_function_obj"
  end

  add_index "system_function_operates", ["is_active"], :name => "index_system_function_operates_on_is_active"
  add_index "system_function_operates", ["system_function_id"], :name => "index_system_function_operates_on_system_function_id"

  create_table "system_functions", :force => true do |t|
    t.integer  "system_function_group_id",                                 :null => false
    t.string   "subject_title",            :limit => 30,                   :null => false
    t.integer  "order",                                  :default => 1
    t.boolean  "is_active",                              :default => true, :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.text     "default_action"
  end

  add_index "system_functions", ["is_active"], :name => "index_system_functions_on_is_active"
  add_index "system_functions", ["system_function_group_id"], :name => "index_system_functions_on_system_function_group_id"

  create_table "task_participation_users", :force => true do |t|
    t.integer  "task_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "task_progresses", :force => true do |t|
    t.integer  "task_id",    :null => false
    t.integer  "user_id",    :null => false
    t.text     "content",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "task_progresses", ["task_id"], :name => "index_task_progresses_on_task_id"
  add_index "task_progresses", ["user_id"], :name => "index_task_progresses_on_user_id"

  create_table "task_users", :force => true do |t|
    t.integer  "task_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "title",              :limit => 60,                      :null => false
    t.text     "content",                                               :null => false
    t.date     "plan_complete_date",                                    :null => false
    t.string   "state",              :limit => 30, :default => "draft", :null => false
    t.integer  "creator_id"
    t.string   "acceptor_id"
    t.datetime "accept_date"
    t.integer  "submitor_id"
    t.datetime "submit_date"
    t.integer  "auditor_id"
    t.datetime "audit_date"
    t.text     "note"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "audit_state",        :limit => 30, :default => "draft", :null => false
    t.text     "finsh_content"
  end

  create_table "transit_companies", :force => true do |t|
    t.string   "name",       :limit => 60,                   :null => false
    t.string   "address",    :limit => 60
    t.string   "phone",      :limit => 30
    t.boolean  "is_active",                :default => true
    t.text     "note"
    t.string   "leader",     :limit => 20
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "transit_companies", ["is_active"], :name => "index_transit_companies_on_is_active"

  create_table "transit_deliver_infos", :force => true do |t|
    t.integer  "org_id",                                                        :null => false
    t.date     "bill_date",                                                     :null => false
    t.text     "note"
    t.decimal  "transit_hand_fee",               :precision => 15, :scale => 2
    t.string   "state",            :limit => 20
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "user_id"
  end

  add_index "transit_deliver_infos", ["bill_date"], :name => "index_transit_deliver_infos_on_bill_date"
  add_index "transit_deliver_infos", ["org_id"], :name => "index_transit_deliver_infos_on_org_id"
  add_index "transit_deliver_infos", ["state"], :name => "index_transit_deliver_infos_on_state"
  add_index "transit_deliver_infos", ["user_id"], :name => "index_transit_deliver_infos_on_user_id"

  create_table "transit_infos", :force => true do |t|
    t.integer  "org_id",                                                                             :null => false
    t.integer  "user_id"
    t.integer  "transit_company_id",                                                                 :null => false
    t.string   "to_station_phone",     :limit => 30
    t.date     "bill_date",                                                                          :null => false
    t.string   "state",                :limit => 20
    t.decimal  "transit_carrying_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.text     "note"
    t.datetime "created_at",                                                                         :null => false
    t.datetime "updated_at",                                                                         :null => false
  end

  add_index "transit_infos", ["bill_date"], :name => "index_transit_infos_on_bill_date"
  add_index "transit_infos", ["org_id"], :name => "index_transit_infos_on_org_id"
  add_index "transit_infos", ["state"], :name => "index_transit_infos_on_state"
  add_index "transit_infos", ["transit_company_id"], :name => "index_transit_infos_on_transit_company_id"
  add_index "transit_infos", ["user_id"], :name => "index_transit_infos_on_user_id"

  create_table "user_orgs", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "org_id",                        :null => false
    t.boolean  "is_select",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.boolean  "is_select",  :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "user_roles", ["is_select"], :name => "index_user_roles_on_is_select"
  add_index "user_roles", ["role_id"], :name => "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => ""
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "is_active",                           :default => true
    t.boolean  "is_admin",                            :default => false
    t.string   "username",             :limit => 20,                     :null => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.integer  "default_org_id"
    t.integer  "default_role_id"
    t.boolean  "use_usb",                             :default => false
    t.string   "usb_pin",              :limit => 32
    t.string   "real_name",            :limit => 20
    t.string   "authentication_token"
  end

  add_index "users", ["is_active"], :name => "index_users_on_is_active"
  add_index "users", ["is_admin"], :name => "index_users_on_is_admin"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "view_bills", :id => false, :force => true do |t|
    t.string  "bill_no",          :limit => 30,                                                 :null => false
    t.decimal "goods_fee",                      :precision => 10, :scale => 2, :default => 0.0
    t.string  "state",            :limit => 60
    t.integer "from_customer_id"
    t.decimal "act_pay_fee",                    :precision => 19, :scale => 2
  end

  create_table "votable_item_orgs", :force => true do |t|
    t.integer  "votable_item_id"
    t.integer  "org_id"
    t.boolean  "selected"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "votable_item_orgs", ["org_id"], :name => "index_votable_item_orgs_on_org_id"
  add_index "votable_item_orgs", ["selected"], :name => "index_votable_item_orgs_on_selected"
  add_index "votable_item_orgs", ["votable_item_id"], :name => "index_votable_item_orgs_on_votable_item_id"

  create_table "votable_items", :force => true do |t|
    t.integer  "vote_config_id",                              :null => false
    t.string   "name",           :limit => 20,                :null => false
    t.integer  "order_by",                     :default => 0
    t.text     "note"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "vote_configs", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "mth",                       :null => false
    t.date     "expire_date"
    t.text     "note"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "type",        :limit => 60
  end

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], :name => "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], :name => "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end

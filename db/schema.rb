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

ActiveRecord::Schema.define(version: 20190128191817) do

  create_table "access_internets", force: :cascade do |t|
    t.float    "total_traffic"
    t.float    "hfc_cgn"
    t.float    "hfc_public"
    t.float    "hfc_ipv6"
    t.float    "hfc"
    t.float    "mobile_cgn"
    t.float    "mobile_corporate"
    t.float    "mobile_ipv6"
    t.float    "mobile"
    t.float    "mobile_olo"
    t.float    "corporate"
    t.float    "cache_in"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "cacheakamai_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "nodo"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cachefacebook_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "nodo"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cachegoogle_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "nodo"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cachenetflix_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "nodo"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cacheudni_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "nodo"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "core_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "servicio"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "internet_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "servicio"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "status"
    t.float    "egressRate"
    t.string   "neighbor"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ipranaccess_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "description"
    t.float    "egressRate"
    t.string   "speed"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "bps_max"
    t.float    "status"
    t.float    "crecimiento"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ipranedge_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "description"
    t.float    "egressRate"
    t.string   "speed"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "bps_max"
    t.float    "status"
    t.float    "crecimiento"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ppmcacheakamais", force: :cascade do |t|
    t.text     "ppmcacheakamais_array"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "ppmcachefacebooks", force: :cascade do |t|
    t.text     "ppmcachefacebooks_array"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "ppmcachegoogles", force: :cascade do |t|
    t.text     "ppmcachegoogles_array"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "ppmcachenetflixes", force: :cascade do |t|
    t.text     "ppmcachenetflixs_array"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ppmcacheudns", force: :cascade do |t|
    t.text     "ppmcacheudns_array"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "ppminterfaceclientinternets", force: :cascade do |t|
    t.text     "ppminterfaceclientinternets_array"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "ppminterfacecores", force: :cascade do |t|
    t.text     "ppminterfacecores_array"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "ppminterfaceinternets", force: :cascade do |t|
    t.text     "ppminterfaceinternets_array"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "ppminterfacepreaggs", force: :cascade do |t|
    t.text     "ppminterfacepreaggs_array"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "ppmpacketcores", force: :cascade do |t|
    t.text     "ppmpacketcores_array"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "ppmredcorporativainterfaces", force: :cascade do |t|
    t.text     "ppmredcorporativainterfaces_array"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "ppmroutes", force: :cascade do |t|
    t.text     "ppmroutes_array"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "preagg_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "servicio"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "redcorporativa_interfaces", force: :cascade do |t|
    t.string   "device"
    t.string   "port"
    t.string   "servicio"
    t.float    "gbpsrx"
    t.float    "gbpstx"
    t.float    "bps_max"
    t.float    "statustx"
    t.float    "statusrx"
    t.float    "status"
    t.float    "last_bps_max"
    t.float    "last_status"
    t.float    "crecimiento_rx"
    t.float    "crecimiento_tx"
    t.float    "egressRate"
    t.date     "time"
    t.text     "comment"
    t.string   "deviceindex"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "samaztecainterfaces", force: :cascade do |t|
    t.text     "samaztecainterfaces_array"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "samcpus", force: :cascade do |t|
    t.text     "samcpus_array"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "samenvironments", force: :cascade do |t|
    t.text     "samenvironments_array"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "samgilatinterfaces", force: :cascade do |t|
    t.text     "samgilatinterfaces_array"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "saminterfacediscards", force: :cascade do |t|
    t.text     "saminterfacediscards_array"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "saminternexainterfaces", force: :cascade do |t|
    t.text     "saminternexainterfaces_array"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "sammemos", force: :cascade do |t|
    t.text     "sammemos_array"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "samospfalarmas", force: :cascade do |t|
    t.text     "samospfalarmas_array"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "samqos7705egressdiscards", force: :cascade do |t|
    t.text     "samqos7705egressdiscards_array"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "samqos7705ingressdiscards", force: :cascade do |t|
    t.text     "samqos7705ingressdiscards_array"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "samqos7750egressdiscards", force: :cascade do |t|
    t.text     "samqos7750egressdiscards_array"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "samqos7750egressnetdiscards", force: :cascade do |t|
    t.text     "samqos7750egressnetdiscards_array"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "samroutebgps", force: :cascade do |t|
    t.text     "samroutebgps_array"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "samrouteldps", force: :cascade do |t|
    t.text     "samrouteldps_array"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "samrouteospfs", force: :cascade do |t|
    t.text     "samrouteospfs_array"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "samroutevprns", force: :cascade do |t|
    t.text     "samroutevprns_array"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "samstatusports", force: :cascade do |t|
    t.text     "samstatusports_array"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "samutilizationaccesointerfaces", force: :cascade do |t|
    t.text     "samutilizationaccesointerfaces_array"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "samutilizationinterfaces", force: :cascade do |t|
    t.text     "samutilizationinterfaces_array"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "samutilizationmwinterfaces", force: :cascade do |t|
    t.text     "samutilizationmwinterfaces_array"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "session_accedians", force: :cascade do |t|
    t.string   "ip_endpoint"
    t.string   "name_endpoint"
    t.string   "product_endpoint"
    t.string   "state_endpoint"
    t.string   "type_endpoint"
    t.string   "capability"
    t.string   "port_endpoint"
    t.string   "tos_endpoint"
    t.string   "name_session"
    t.string   "sessionType"
    t.float    "sid"
    t.string   "dstEndpoint"
    t.float    "dstPort"
    t.string   "srcEndpoint"
    t.string   "srcIfc"
    t.float    "srcPort"
    t.string   "state_session"
    t.float    "interval_session"
    t.float    "tos_session"
    t.float    "payloadsize_session"
    t.float    "pps_session"
    t.string   "type_port"
    t.string   "sla"
    t.string   "status_device"
    t.string   "ip_interface_vcx"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "spattackalerts", force: :cascade do |t|
    t.text     "spattackalerts_array"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

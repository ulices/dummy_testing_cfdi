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

ActiveRecord::Schema.define(version: 20131121223458) do

  create_table "electronic_invoices", force: true do |t|
    t.string   "request"
    t.string   "xml_response"
    t.string   "txt_stamp"
    t.string   "cbb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "folio"
    t.string   "serie"
    t.datetime "fecha"
    t.string   "forma_pago"
    t.string   "condiciones_pago"
    t.string   "metodo_pago"
    t.string   "expedido"
    t.string   "numero_cuenta_pago"
    t.string   "moneda"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "rfc"
    t.string   "pass_sat"
    t.string   "certificate_url"
    t.string   "key_url"
    t.binary   "encryption_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

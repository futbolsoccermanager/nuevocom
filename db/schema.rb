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

ActiveRecord::Schema.define(:version => 20121118152813) do

  create_table "equipos", :force => true do |t|
    t.string   "nombre"
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jugadores", :force => true do |t|
    t.integer  "equipo_id"
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "apodo"
    t.string   "foto"
    t.float    "precio"
    t.integer  "dorsal"
    t.string   "posicion"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ligas", :force => true do |t|
    t.string   "nombre"
    t.integer  "creador"
    t.string   "logo"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "privacidad",            :limit => 1
    t.string   "password"
    t.integer  "maximo_miembros"
    t.integer  "presupuesto_inicial"
    t.integer  "num_jugadores_mercado"
  end

  create_table "mercados", :force => true do |t|
    t.integer  "jugador_id"
    t.integer  "liga_id"
    t.date     "fecha_inclusion"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "oferta", :force => true do |t|
    t.integer  "seleccion_id"
    t.integer  "mercado_id"
    t.float    "valor"
    t.date     "fecha"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "plantilla_selecciones", :force => true do |t|
    t.integer  "seleccion_id"
    t.integer  "jugador_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "titular"
  end

  create_table "selecciones", :force => true do |t|
    t.integer  "user_id"
    t.string   "nombre"
    t.string   "escudo"
    t.integer  "liga_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "fecha_visto"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

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

ActiveRecord::Schema.define(:version => 20130426235738) do

  create_table "documentos", :force => true do |t|
    t.integer  "tipo"
    t.date     "fecha_vencimiento"
    t.boolean  "alerta"
    t.date     "fecha_emision"
    t.string   "archivo"
    t.integer  "producto_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "documentos", ["producto_id"], :name => "index_documentos_on_producto_id"

  create_table "importadors", :force => true do |t|
    t.string   "rif"
    t.string   "nombre"
    t.string   "pais_origen"
    t.string   "mail"
    t.string   "telefono"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "logs", :force => true do |t|
    t.datetime "fecha_hora"
    t.text     "descripcion"
    t.integer  "usuario_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "logs", ["usuario_id"], :name => "index_logs_on_usuario_id"

  create_table "presentacions", :force => true do |t|
    t.string   "cpe"
    t.date     "fecha_vencimiento"
    t.string   "empaque"
    t.integer  "peso_neto"
    t.integer  "peso_escurrido"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "productos", :force => true do |t|
    t.string   "registro_sanitario"
    t.boolean  "alimento"
    t.string   "nombre"
    t.string   "marca"
    t.string   "pais_elaboracion"
    t.string   "fabricante"
    t.string   "codigo_arancelario"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "requisitos", :force => true do |t|
    t.text     "descripcion"
    t.text     "observacion"
    t.integer  "estado"
    t.integer  "tramite_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "requisitos", ["tramite_id"], :name => "index_requisitos_on_tramite_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tramites", :force => true do |t|
    t.string   "codigo_seguimiento"
    t.integer  "tipo"
    t.integer  "estado"
    t.date     "fecha_recepcion"
    t.text     "observacion"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "login"
    t.string   "telefono"
    t.string   "nombre"
    t.string   "apellido"
    t.string   "compania"
    t.string   "rif"
    t.integer  "admin"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
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
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end

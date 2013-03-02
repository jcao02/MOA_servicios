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

ActiveRecord::Schema.define(:version => 20130302223234) do

  create_table "documentos", :force => true do |t|
    t.integer  "tipo"
    t.date     "fecha_vencimiento"
    t.boolean  "alerta"
    t.date     "fecha_emision"
    t.string   "archivo"
    t.integer  "producto_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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
    t.string   "contrasena"
    t.string   "mail"
    t.string   "telefono"
    t.string   "nombre"
    t.string   "apellido"
    t.string   "compania"
    t.string   "rif"
    t.integer  "admin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

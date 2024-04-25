# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_25_025737) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "authentication_token", limit: 30, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_admins_on_authentication_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "api_apikeys", force: :cascade do |t|
    t.string "name"
    t.string "api_key_value"
    t.string "email"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_documentos", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.string "clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clave"], name: "index_tipo_documentos_on_clave", unique: true
  end

  create_table "tipo_usuarios", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.string "clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clave"], name: "index_tipo_usuarios_on_clave", unique: true
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.string "razon_social", default: "", null: false
    t.string "correo", default: "", null: false
    t.string "telefono_principal", default: "", null: false
    t.string "telefono_secundario", default: "", null: false
    t.string "numero_documento", null: false
    t.date "fecha_emicion_doc", null: false
    t.date "fecha_vencimiento_doc", null: false
    t.integer "tipo_usuario_id", null: false
    t.integer "tipo_documento_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["correo"], name: "index_usuarios_on_correo", unique: true
    t.index ["numero_documento"], name: "index_usuarios_on_numero_documento", unique: true
    t.index ["telefono_principal"], name: "index_usuarios_on_telefono_principal", unique: true
    t.index ["tipo_documento_id"], name: "index_usuarios_on_tipo_documento_id"
    t.index ["tipo_usuario_id"], name: "index_usuarios_on_tipo_usuario_id"
  end

  add_foreign_key "usuarios", "tipo_documentos", on_delete: :restrict
  add_foreign_key "usuarios", "tipo_usuarios", on_delete: :restrict
end

class CreateUsuarios < ActiveRecord::Migration[7.1]
  def change
    create_table :usuarios do |t|
      t.string :nombre, null: false, default: ""
      t.string :razon_social, null: false, default: ""
      t.string :correo, null: false, default: ""
      t.string :telefono_principal, null: false, default: ""
      t.string :telefono_secundario, null: false, default: ""
      t.integer :numero_documento, null: false
      t.date :fecha_emicion_doc, null: false
      t.date :fecha_vencimiento_doc, null: false
      t.integer :tipo_usuario_id,  null: false
      t.integer :tipo_documento_id,  null: false

      t.timestamps
    end
    add_index :usuarios, :correo, unique: true
    add_index :usuarios, :numero_documento, unique: true
    add_index :usuarios, :telefono_principal, unique: true
  end
end

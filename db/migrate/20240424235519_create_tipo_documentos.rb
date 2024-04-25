class CreateTipoDocumentos < ActiveRecord::Migration[7.1]
  def change
    create_table :tipo_documentos do |t|
      t.string :nombre, null: false, default: ""
      t.string :clave
      t.timestamps
    end
    add_index :tipo_documentos, :clave, unique: true
  end
end

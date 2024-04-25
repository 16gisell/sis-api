class CreateTipoUsuarios < ActiveRecord::Migration[7.1]
  def change
    create_table :tipo_usuarios do |t|
      t.string :nombre, null: false, default: ""
      t.string :clave

      t.timestamps
    end
    add_index :tipo_usuarios, :clave, unique: true
  end
end

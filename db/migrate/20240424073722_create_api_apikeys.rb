class CreateApiApikeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_apikeys do |t|
      t.string :name
      t.string :api_key_value
      t.string :email
      t.datetime :expires_at

      t.timestamps
    end
  end
end

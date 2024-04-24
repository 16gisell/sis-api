class CreateApiV1Users < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_users do |t|

      t.timestamps
    end
  end
end

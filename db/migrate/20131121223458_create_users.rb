class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :rfc
      t.string :pass_sat
      t.string :certificate_url
      t.string :key_url
      t.binary :encryption_key

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :access_token
      t.string :name
      t.string :nick_name

      t.timestamps
    end
  end
end

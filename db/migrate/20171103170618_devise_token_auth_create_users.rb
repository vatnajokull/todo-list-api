class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      t.json :tokens
    end

    add_index :users, %i(provider uid), unique: true
  end
end

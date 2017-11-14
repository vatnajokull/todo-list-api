class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.belongs_to :user, foreign_key: true
      t.text :body
      t.string :attachment

      t.timestamps
    end
  end
end

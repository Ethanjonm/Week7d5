class CreateSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.bigint :moderator, null: false
      t.timestamps
    end
    add_index :subs, :title
    add_index :subs, :moderator, unique: true
  end
end

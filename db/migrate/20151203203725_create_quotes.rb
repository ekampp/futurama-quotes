class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :person, default: 'Unknown'
      t.text :text, null: false
      t.timestamps
    end
  end
end

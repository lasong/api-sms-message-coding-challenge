class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :part_number
      t.string :uuid

      t.timestamps
    end
  end
end

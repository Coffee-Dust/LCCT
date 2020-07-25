class CreateCasesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :cases_tables do |t|
      t.integer :total
      t.integer :active
      t.integer :deaths
      t.timestamps null: true
    end
  end
end

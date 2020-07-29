class ChangeCasesTablesToCases < ActiveRecord::Migration[6.0]
  def change
    rename_table :cases_tables, :cases
  end
end

class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.references :source_account, null: false, foreign_key: { to_table: :accounts }
      t.references :destination_account, null: false, foreign_key: { to_table: :accounts }
      t.references :source_event, null: false, foreign_key: { to_table: :events }
      t.references :destination_event, null: false, foreign_key: { to_table: :events }
      t.decimal :amount

      t.timestamps
    end
  end
end

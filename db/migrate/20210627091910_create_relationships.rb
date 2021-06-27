class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.bigint :user_id, null: false
      t.bigint :user_relationship_id, null: false
      t.string :relationship_type, null: false

      t.timestamps
    end

    add_foreign_key(:relationships, :users, column: :user_id)
    add_foreign_key(:relationships, :users, column: :user_relationship_id)
  end
end

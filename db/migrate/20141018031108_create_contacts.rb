class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :agent_id
      t.string :phone
      t.boolean :default
      t.timestamps
    end
  end
end

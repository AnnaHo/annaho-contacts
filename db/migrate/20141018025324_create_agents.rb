class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name, :null => false
    end
  end
end

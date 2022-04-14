class CreateMissions < ActiveRecord::Migration[7.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.references :scientist
      t.references :planet
      t.timestamps
    end
  end
end

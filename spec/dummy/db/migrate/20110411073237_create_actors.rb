class CreateActors < ActiveRecord::Migration[7.0]
  def self.up
    create_table :actors do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :actors
  end
end

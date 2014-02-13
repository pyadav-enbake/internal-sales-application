class CreateStates < ActiveRecord::Migration
  def up
    create_table :states do |t|
      t.string :name
      t.string :abbr
    end
    say_with_time "Importing states from 'test/fixtures/state_table.csv'" do
      CSV.table(Rails.root.join("test/fixtures/state_table.csv")).each do |row|
        State.where(name: row[:name], abbr: row[:abbreviation]).first_or_create!
      end
    end
  end

  def down
    drop_table :states
  end
end

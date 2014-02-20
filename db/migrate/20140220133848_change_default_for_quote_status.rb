class ChangeDefaultForQuoteStatus < ActiveRecord::Migration
  def up
    change_column_default :quotes, :status, 0
  end

  def down
    change_column_default :quotes, :status, 1
  end
end

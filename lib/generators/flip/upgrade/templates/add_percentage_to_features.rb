class AddPercentageToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :percentage, :integer
  end
end

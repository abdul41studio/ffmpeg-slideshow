class AddOrderToMedia < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :order, :integer
  end
end

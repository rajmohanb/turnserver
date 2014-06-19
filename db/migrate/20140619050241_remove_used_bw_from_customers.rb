class RemoveUsedBwFromCustomers < ActiveRecord::Migration
  def up
    remove_column :customers, :used_bw
  end

  def down
    add_column :customers, :used_bw, :integer, default: 0

    Customer.reset_column_information

    Customer.all.each do |customer|
      customer.save
    end
  end
end

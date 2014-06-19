class AddBandwidthDetailsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :allowed_bw, :integer, default: 1024
    add_column :customers, :used_bw, :integer, default: 0

    Customer.reset_column_information

    Customer.all.each do |customer|
      customer.save
    end
  end
end

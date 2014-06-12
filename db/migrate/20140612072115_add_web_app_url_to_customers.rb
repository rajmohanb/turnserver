class AddWebAppUrlToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :webapp_url, :string
    add_index :customers, :webapp_url, unique: true

    Customer.reset_column_information

    Customer.all.each do |customer|
      customer.webapp_url = customer.first_name
      customer.save
    end

    change_column :customers, :webapp_url, :string, :null => false
  end
end

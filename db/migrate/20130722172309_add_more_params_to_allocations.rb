class AddMoreParamsToAllocations < ActiveRecord::Migration
  def change
    add_column :allocations, :protocol, :string
    add_column :allocations, :ingress_data, :integer
    add_column :allocations, :egress_data, :integer
    add_column :allocations, :total_relay, :integer
    add_column :allocations, :alloc_handle, :integer, :limit => 8
  end
end

class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|

      t.integer :req_lifetime
      t.integer :allotted_lifetime
      t.integer :bandwidth_used
      t.datetime :alloc_at
      t.datetime :dealloc_at

      t.timestamps
    end
  end
end

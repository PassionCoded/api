class AddUserToPassions < ActiveRecord::Migration
  def change
    add_reference :passions, :user, index: true
  end
end

class AddUserIdToSurveys < ActiveRecord::Migration
  def change
  	add_column :surveys, :user_id, :string
  	add_index :surveys, [:user_id, :created_at]
  end
end

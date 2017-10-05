class CreateBadges < ActiveRecord::Migration[5.1]
  def change
    create_table :badges do |t|
    	t.references :user
    	t.references :achievement
      t.timestamps
    end
  end
end

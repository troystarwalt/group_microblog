class AddThrowsTable < ActiveRecord::Migration
  def change
  	create_table :throws do |t|
	  	t.integer 		:user_id		
		t.text 			:throwpost
		t.datetime 		:created_at
  	end
  end
end

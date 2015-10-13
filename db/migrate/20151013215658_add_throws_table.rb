class AddThrowsTable < ActiveRecord::Migration
  def change
  	create_table :throws do |t|
	  	t.integer 		:user_id		
		t.text 			:throwpost
		t.datetime 		:create_at
  	end
  end
end

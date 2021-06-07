#coding: utf-8
class AddTransitLoadListCols < ActiveRecord::Migration
  def up
    add_column :load_lists,:transit_reached_datetime,:datetime
    add_column :load_lists,:transit_reached_user_id,:integer
    add_column :load_lists,:transit_ship_datetime,:datetime
    add_column :load_lists,:transit_ship_user_id,:integer
  end

  def down
    remove_column :load_lists,:transit_reached_datetime
    remove_column :load_lists,:transit_reached_user_id
    remove_column :load_lists,:transit_ship_datetime
    remove_column :load_lists,:transit_ship_user_id

  end
end

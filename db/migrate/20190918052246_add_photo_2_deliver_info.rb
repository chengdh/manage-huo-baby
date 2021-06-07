#coding: utf-8
class AddPhoto2DeliverInfo < ActiveRecord::Migration
  def up
    add_attachment :deliver_infos, :photo_1
    add_attachment :deliver_infos, :photo_2
  end

  def down
    remove_attachment :deliver_infos, :photo_1
    remove_attachment :deliver_infos, :photo_2
  end
end

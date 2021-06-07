#coding: utf-8
class AddAttachmentPhotoToGoodsExceptions < ActiveRecord::Migration
  def self.up
    change_table :goods_exceptions do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :goods_exceptions, :photo
  end
end

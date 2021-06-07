#coding: utf-8
#条码装车明细
class LoadListWithBarcodeLine < ActiveRecord::Base
  belongs_to :load_list_with_barcode
  belongs_to :carrying_bill
  has_attached_file :goods_photo_1, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_attached_file :goods_photo_2, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :goods_photo_1, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :goods_photo_1, :content_type => /\Aimage\/.*\Z/
end

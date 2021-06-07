#coding: utf-8
class AddValidateDateToRemittance < ActiveRecord::Migration
  def change
    add_column :remittances, :validate_date, :datetime
  end
end

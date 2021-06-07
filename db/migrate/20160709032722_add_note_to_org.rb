#coding: utf-8
class AddNoteToOrg < ActiveRecord::Migration
  def change
    add_column :orgs,:note,:text
  end
end

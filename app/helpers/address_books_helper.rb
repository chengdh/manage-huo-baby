#coding: utf-8
module AddressBooksHelper
  def address_book_tags
    [["分理处","address_book_tag_department"],["分公司","address_book_tag_branch"],["科室","address_book_tag_other"],["装卸组","address_book_tag_load"]]
  end
end

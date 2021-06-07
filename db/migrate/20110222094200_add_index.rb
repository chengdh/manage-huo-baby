# -*- encoding : utf-8 -*-
#coding: utf-8
class AddIndex < ActiveRecord::Migration
  def self.up

    ################################carrying_bills#########################
    add_index :carrying_bills,:bill_date
    add_index :carrying_bills,:bill_no
    add_index :carrying_bills,:goods_no
    add_index :carrying_bills,:from_customer_id
    add_index :carrying_bills,:from_customer_name
    add_index :carrying_bills,:to_customer_id
    add_index :carrying_bills,:to_customer_name
    add_index :carrying_bills,:from_org_id
    add_index :carrying_bills,:transit_org_id
    add_index :carrying_bills,:to_org_id
    add_index :carrying_bills,:pay_type
    add_index :carrying_bills,:type
    add_index :carrying_bills,:state
    add_index :carrying_bills,:user_id
    add_index :carrying_bills,:original_bill_id
    add_index :carrying_bills,:load_list_id
    add_index :carrying_bills,:deliver_info_id
    add_index :carrying_bills,:settlement_id
    add_index :carrying_bills,:refound_id
    add_index :carrying_bills,:payment_list_id
    add_index :carrying_bills,:pay_info_id
    add_index :carrying_bills,:post_info_id
    add_index :carrying_bills,:transit_info_id
    add_index :carrying_bills,:transit_deliver_info_id
    add_index :carrying_bills,:short_fee_info_id
    add_index :carrying_bills,:completed
    ################################carrying_bills#########################


    ########################claims#######################################
    add_index :claims,:bill_date
    add_index :claims,:goods_exception_id
    add_index :claims,:user_id
    ########################claims#######################################


    ########################customers#######################################
    add_index :customers,:org_id
    add_index :customers,:name
    add_index :customers,:phone
    add_index :customers,:mobile
    add_index :customers,:code
    add_index :customers,:id_number
    add_index :customers,:bank_id
    add_index :customers,:bank_card
    add_index :customers,:type
    add_index :customers,:is_active
    add_index :customers,:level
    add_index :customers,:last_import_mth
    add_index :customers,:state
    ########################customers#######################################


    ########################customer_fee_infos#######################################
    add_index :customer_fee_infos,:org_id
    add_index :customer_fee_infos,:mth
    add_index :customer_fee_infos,:user_id
    ########################customer_fee_infos#######################################

    ########################customer_fee_info_lines#######################################
    add_index :customer_fee_info_lines,:customer_fee_info_id

    ########################customer_fee_info_lines#######################################

    #########customer_level_config###################
    add_index :customer_level_configs,:org_id
    #########customer_level_config###################


    ###############deliver_infos#####################
    add_index :deliver_infos,:deliver_date
    add_index :deliver_infos,:org_id
    add_index :deliver_infos,:user_id
    add_index :deliver_infos,:state
    ###############deliver_infos#####################

    ###############distribution_lists#####################
    add_index :distribution_lists,:bill_date
    add_index :distribution_lists,:org_id
    add_index :distribution_lists,:user_id
    add_index :distribution_lists,:state
    ###############distribution_lists#####################



    ###############gexception_authorize_infos#####################
    add_index :gexception_authorize_infos,:bill_date
    add_index :gexception_authorize_infos,:op_type
    add_index :gexception_authorize_infos,:user_id
    add_index :gexception_authorize_infos,:goods_exception_id
    ###############gexception_authorize_infos#####################



    ###############goods_exceptions#####################
    add_index :goods_exceptions,:bill_date
    add_index :goods_exceptions,:org_id
    add_index :goods_exceptions,:carrying_bill_id
    add_index :goods_exceptions,:exception_type
    add_index :goods_exceptions,:user_id
    add_index :goods_exceptions,:state
    ###############goods_exceptions#####################



    ###############goods_exception_identifies#####################
    add_index :goods_exception_identifies,:bill_date
    add_index :goods_exception_identifies,:user_id
    ###############goods_exception_identifies#####################



    ###############il_configs#####################
    add_index :il_configs,:key
    ###############il_configs#####################


    ###############journals#####################
    add_index :journals,:org_id
    add_index :journals,:bill_date
    add_index :journals,:user_id
    ###############il_configs#####################


    ###############load_lists#####################
    add_index :load_lists,:bill_date
    add_index :load_lists,:bill_no
    add_index :load_lists,:from_org_id
    add_index :load_lists,:to_org_id
    add_index :load_lists,:state
    add_index :load_lists,:user_id
    ###############load_lists#####################

    ###############orgs#####################
    add_index :orgs,:type
    add_index :orgs,:parent_id
    add_index :orgs,:name
    add_index :orgs,:simp_name
    add_index :orgs,:code
    ###############load_lists#####################

    ###############payment_lists#####################
    add_index :payment_lists,:org_id
    add_index :payment_lists,:bank_id
    add_index :payment_lists,:user_id
    add_index :payment_lists,:state
    add_index :payment_lists,:type
    add_index :payment_lists,:bill_date
    ###############payment_lists#####################

    ###############pay_infos#####################
    add_index :pay_infos,:org_id
    add_index :pay_infos,:user_id
    add_index :pay_infos,:type
    add_index :pay_infos,:state
    add_index :pay_infos,:bill_date
    ###############payment##########################

    ###############post_infos#####################
    add_index :post_infos,:org_id
    add_index :post_infos,:user_id
    add_index :post_infos,:state
    add_index :post_infos,:bill_date
    ###############post_infos##########################

    ###############refounds#####################
    add_index :refounds,:from_org_id
    add_index :refounds,:to_org_id
    add_index :refounds,:user_id
    add_index :refounds,:state
    add_index :refounds,:bill_date
    ###############refounds##########################


    ###############remittances#####################
    add_index :remittances,:from_org_id
    add_index :remittances,:to_org_id
    add_index :remittances,:user_id
    add_index :remittances,:state
    add_index :remittances,:bill_date
    add_index :remittances,:refound_id
    ###############refounds##########################

    ###############roles#####################
    add_index :roles,:name
    add_index :roles,:is_active
    ###############roles##########################


    ###############role_system_function_operates#####################
    add_index :role_system_function_operates,:role_id
    add_index :role_system_function_operates,:system_function_operate_id,:name => "rsfo_sf_operate_idx"
    add_index :role_system_function_operates,:is_select
    ###############role_system_function_operates##########################

    ###############senders#####################
    add_index :senders,:name
    add_index :senders,:org_id
    add_index :senders,:is_active
    ###############senders##########################

    ###############sende_lists#####################
    add_index :send_lists,:bill_date
    add_index :send_lists,:sender_id
    add_index :send_lists,:org_id
    add_index :send_lists,:user_id
    ###############send_lists##########################

    ###############sende_list_backs#####################
    add_index :send_list_backs,:bill_date
    add_index :send_list_backs,:sender_id
    add_index :send_list_backs,:org_id
    add_index :send_list_backs,:user_id
    ###############send_list_backs##########################

    ###############sende_list_posts#####################
    add_index :send_list_posts,:bill_date
    add_index :send_list_posts,:sender_id
    add_index :send_list_posts,:org_id
    add_index :send_list_posts,:user_id
    ###############send_list_posts##########################

    ###############sende_list_lines#####################
    add_index :send_list_lines,:send_list_id
    add_index :send_list_lines,:send_list_back_id
    add_index :send_list_lines,:send_list_post_id
    add_index :send_list_lines,:state
    add_index :send_list_lines,:carrying_bill_id
    ###############send_list_lines##########################


    ###############settlements#####################
    add_index :settlements,:org_id
    add_index :settlements,:user_id
    add_index :settlements,:state
    add_index :settlements,:bill_date
    ###############settlements##########################


    ###############short_fee_infos#####################
    add_index :short_fee_infos,:org_id
    add_index :short_fee_infos,:user_id
    add_index :short_fee_infos,:state
    add_index :short_fee_infos,:bill_date
    ###############short_fee_infos##########################


    ###############system_functions#####################
    add_index :system_functions,:system_function_group_id
    add_index :system_functions,:is_active
    ###############system_functions#####################


    ###############system_function_groups#####################
    add_index :system_function_groups,:is_active
    ###############system_functions#####################


    ###############system_function_operates#####################
    add_index :system_function_operates,:system_function_id
    add_index :system_function_operates,:is_active
    ###############system_function_operates#####################


    ###############transit_companies#####################
    add_index :transit_companies,:is_active
    ###############transit_companies#####################


    remove_column :transit_deliver_infos,:uer_id
    add_column :transit_deliver_infos,:user_id,:integer
    ###############transit_deliver_infos#####################
    add_index :transit_deliver_infos,:org_id
    add_index :transit_deliver_infos,:user_id
    add_index :transit_deliver_infos,:bill_date
    add_index :transit_deliver_infos,:state

    ###############transit_deliver_infos#####################


    ###############transit_infos#####################
    add_index :transit_infos,:org_id
    add_index :transit_infos,:user_id
    add_index :transit_infos,:bill_date
    add_index :transit_infos,:state
    add_index :transit_infos,:transit_company_id
    ###############transit_infos#####################


    ###############users#####################
    add_index :users,:is_active
    add_index :users,:is_admin
    ###############users#####################


    ###############user_roles#####################
    add_index :user_roles,:user_id
    add_index :user_roles,:role_id
    add_index :user_roles,:is_select
    ###############users#####################

  end


  def self.down

    ################################carrying_bills#########################
    remove_index :carrying_bills,:column => :bill_date
    remove_index :carrying_bills,:column => :bill_no
    remove_index :carrying_bills,:column => :goods_no
    remove_index :carrying_bills,:column => :from_customer_id
    remove_index :carrying_bills,:column => :from_customer_name
    remove_index :carrying_bills,:column => :to_customer_id
    remove_index :carrying_bills,:column => :to_customer_name
    remove_index :carrying_bills,:column => :from_org_id
    remove_index :carrying_bills,:column => :transit_org_id
    remove_index :carrying_bills,:column => :to_org_id
    remove_index :carrying_bills,:column => :pay_type
    remove_index :carrying_bills,:column => :type
    remove_index :carrying_bills,:column => :state
    remove_index :carrying_bills,:column => :user_id
    remove_index :carrying_bills,:column => :original_bill_id
    remove_index :carrying_bills,:column => :load_list_id
    remove_index :carrying_bills,:column => :deliver_info_id
    remove_index :carrying_bills,:column => :settlement_id
    remove_index :carrying_bills,:column => :refound_id
    remove_index :carrying_bills,:column => :payment_list_id
    remove_index :carrying_bills,:column => :pay_info_id
    remove_index :carrying_bills,:column => :post_info_id
    remove_index :carrying_bills,:column => :transit_info_id
    remove_index :carrying_bills,:column => :transit_deliver_info_id
    remove_index :carrying_bills,:column => :short_fee_info_id
    remove_index :carrying_bills,:column => :completed
    ################################carrying_bills#########################


    ########################claims#######################################
    remove_index :claims,:column => :bill_date
    remove_index :claims,:column => :goods_exception_id
    remove_index :claims,:column => :user_id
    ########################claims#######################################


    ########################customers#######################################
    remove_index :customers,:column => :org_id
    remove_index :customers,:column => :name
    remove_index :customers,:column => :phone
    remove_index :customers,:column => :mobile
    remove_index :customers,:column => :code
    remove_index :customers,:column => :id_number
    remove_index :customers,:column => :bank_id
    remove_index :customers,:column => :bank_card
    remove_index :customers,:column => :type
    remove_index :customers,:column => :is_active
    remove_index :customers,:column => :level
    remove_index :customers,:column => :last_import_mth
    remove_index :customers,:column => :state
    ########################customers#######################################


    ########################customer_fee_infos#######################################
    remove_index :customer_fee_infos,:column => :org_id
    remove_index :customer_fee_infos,:column => :mth
    remove_index :customer_fee_infos,:column => :user_id
    ########################customer_fee_infos#######################################

    ########################customer_fee_info_lines#######################################
    remove_index :customer_fee_info_lines,:column => :customer_fee_info_id

    ########################customer_fee_info_lines#######################################

    #########customer_level_config###################
    remove_index :customer_level_configs,:column => :org_id
    #########customer_level_config###################


    ###############deliver_infos#####################
    remove_index :deliver_infos,:column => :deliver_date
    remove_index :deliver_infos,:column => :org_id
    remove_index :deliver_infos,:column => :user_id
    remove_index :deliver_infos,:column => :state
    ###############deliver_infos#####################

    ###############distribution_lists#####################
    remove_index :distribution_lists,:column => :bill_date
    remove_index :distribution_lists,:column => :org_id
    remove_index :distribution_lists,:column => :user_id
    remove_index :distribution_lists,:column => :state
    ###############distribution_lists#####################



    ###############gexception_authorize_infos#####################
    remove_index :gexception_authorize_infos,:column => :bill_date
    remove_index :gexception_authorize_infos,:column => :op_type
    remove_index :gexception_authorize_infos,:column => :user_id
    remove_index :gexception_authorize_infos,:column => :goods_exception_id
    ###############gexception_authorize_infos#####################



    ###############goods_exceptions#####################
    remove_index :goods_exceptions,:column => :bill_date
    remove_index :goods_exceptions,:column => :org_id
    remove_index :goods_exceptions,:column => :carrying_bill_id
    remove_index :goods_exceptions,:column => :exception_type
    remove_index :goods_exceptions,:column => :user_id
    remove_index :goods_exceptions,:column => :state
    ###############goods_exceptions#####################



    ###############goods_exception_identifies#####################
    remove_index :goods_exception_identifies,:column => :bill_date
    remove_index :goods_exception_identifies,:column => :user_id
    ###############goods_exception_identifies#####################



    ###############il_configs#####################
    remove_index :il_configs,:column => :key
    ###############il_configs#####################


    ###############journals#####################
    remove_index :journals,:column => :org_id
    remove_index :journals,:column => :bill_date
    remove_index :journals,:column => :user_id
    ###############il_configs#####################


    ###############load_lists#####################
    remove_index :load_lists,:column => :bill_date
    remove_index :load_lists,:column => :bill_no
    remove_index :load_lists,:column => :from_org_id
    remove_index :load_lists,:column => :to_org_id
    remove_index :load_lists,:column => :state
    remove_index :load_lists,:column => :user_id
    ###############load_lists#####################

    ###############orgs#####################
    remove_index :orgs,:column => :type
    remove_index :orgs,:column => :parent_id
    remove_index :orgs,:column => :name
    remove_index :orgs,:column => :simp_name
    remove_index :orgs,:column => :code
    remove_index :orgs,:column => :type
    ###############load_lists#####################

    ###############payment_lists#####################
    remove_index :payment_lists,:column => :org_id
    remove_index :payment_lists,:column => :bank_id
    remove_index :payment_lists,:column => :user_id
    remove_index :payment_lists,:column => :state
    remove_index :payment_lists,:column => :type
    remove_index :payment_lists,:column => :bill_date
    ###############payment_lists#####################

    ###############pay_infos#####################
    remove_index :pay_infos,:column => :org_id
    remove_index :pay_infos,:column => :user_id
    remove_index :pay_infos,:column => :type
    remove_index :pay_infos,:column => :state
    remove_index :pay_infos,:column => :bill_date
    ###############payment##########################

    ###############post_infos#####################
    remove_index :post_infos,:column => :org_id
    remove_index :post_infos,:column => :user_id
    remove_index :post_infos,:column => :state
    remove_index :post_infos,:column => :bill_date
    ###############post_infos##########################

    ###############refounds#####################
    remove_index :refounds,:column => :from_org_id
    remove_index :refounds,:column => :to_org_id
    remove_index :refounds,:column => :user_id
    remove_index :refounds,:column => :state
    remove_index :refounds,:column => :bill_date
    ###############refounds##########################


    ###############remittances#####################
    remove_index :remittances,:column => :from_org_id
    remove_index :remittances,:column => :to_org_id
    remove_index :remittances,:column => :user_id
    remove_index :remittances,:column => :state
    remove_index :remittances,:column => :bill_date
    remove_index :remittances,:column => :refound_id
    ###############refounds##########################

    ###############roles#####################
    remove_index :roles,:column => :name
    remove_index :roles,:column => :is_active
    ###############roles##########################


    ###############role_system_function_operates#####################
    remove_index :role_system_function_operates,:column => :role_id
    remove_index :role_system_function_operates,:name => "rsfo_sf_operate_idx"
    remove_index :role_system_function_operates,:column => :is_select
    ###############role_system_function_operates##########################

    ###############senders#####################
    remove_index :senders,:column => :name
    remove_index :senders,:column => :org_id
    remove_index :senders,:column => :is_active
    ###############senders##########################

    ###############sende_lists#####################
    remove_index :send_lists,:column => :bill_date
    remove_index :send_lists,:column => :sender_id
    remove_index :send_lists,:column => :org_id
    remove_index :send_lists,:column => :user_id
    ###############send_lists##########################

    ###############sende_list_backs#####################
    remove_index :send_list_backs,:column => :bill_date
    remove_index :send_list_backs,:column => :sender_id
    remove_index :send_list_backs,:column => :org_id
    remove_index :send_list_backs,:column => :user_id
    ###############send_list_backs##########################

    ###############sende_list_posts#####################
    remove_index :send_list_posts,:column => :bill_date
    remove_index :send_list_posts,:column => :sender_id
    remove_index :send_list_posts,:column => :org_id
    remove_index :send_list_posts,:column => :user_id
    ###############send_list_posts##########################

    ###############sende_list_lines#####################
    remove_index :send_list_lines,:column => :send_list_id
    remove_index :send_list_lines,:column => :send_list_back_id
    remove_index :send_list_lines,:column => :send_list_post_id
    remove_index :send_list_lines,:column => :state
    remove_index :send_list_lines,:column => :carrying_bill_id
    ###############send_list_lines##########################


    ###############settlements#####################
    remove_index :settlements,:column => :org_id
    remove_index :settlements,:column => :user_id
    remove_index :settlements,:column => :state
    remove_index :settlements,:column => :bill_date
    ###############settlements##########################


    ###############short_fee_infos#####################
    remove_index :short_fee_infos,:column => :org_id
    remove_index :short_fee_infos,:column => :user_id
    remove_index :short_fee_infos,:column => :state
    remove_index :short_fee_infos,:column => :bill_date
    ###############short_fee_infos##########################


    ###############system_functions#####################
    remove_index :system_functions,:column => :system_function_group_id
    remove_index :system_functions,:column => :is_active
    ###############system_functions#####################


    ###############system_function_groups#####################
    remove_index :system_function_groups,:column => :is_active
    ###############system_functions#####################


    ###############system_function_operates#####################
    remove_index :system_function_operates,:column => :system_function_id
    remove_index :system_function_operates,:column => :is_active
    ###############system_function_operates#####################


    ###############transit_companies#####################
    remove_index :transit_companies,:column => :is_active
    ###############transit_companies#####################


    ###############transit_deliver_infos#####################
    remove_index :transit_deliver_infos,:column => :org_id
    remove_index :transit_deliver_infos,:column => :user_id
    remove_index :transit_deliver_infos,:column => :bill_date
    remove_index :transit_deliver_infos,:column => :state

    ###############transit_deliver_infos#####################


    ###############transit_infos#####################
    remove_index :transit_infos,:column => :org_id
    remove_index :transit_infos,:column => :user_id
    remove_index :transit_infos,:column => :bill_date
    remove_index :transit_infos,:column => :state
    remove_index :transit_infos,:column => :transit_company_id
    ###############transit_infos#####################


    ###############users#####################
    remove_index :users,:column => :username
    remove_index :users,:column => :is_active
    remove_index :users,:column => :is_admin
    ###############users#####################


    ###############user_roles#####################
    remove_index :user_roles,:column => :user_id
    remove_index :user_roles,:column => :role_id
    remove_index :user_roles,:column => :is_select
    ###############users#####################


  end
end


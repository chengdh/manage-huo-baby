# -*- encoding : utf-8 -*-

IlYanzhao::Application.routes.draw do

  resources :divide_rpt_yujius do
    get :before_new,:on => :collection
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :process_handle,:on => :member
  end

  resources :divide_config_yujius

  resources :customer_payment_infos do
    get :search,:on => :collection
    get :export_excel,:on => :member
    put :confirm,:on => :member
  end

  #短驳单确认
  resources :arrive_short_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end

  #短驳单
  resources :short_lists do
    resources :carrying_bills
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :process_handle,:on => :member
  end

  resources :scan_header_sub_branches do
    get :search,:on => :collection
    get :report_workload,:on => :collection
    get :export_excel,:on => :collection
  end

  resources :scan_header_local_town_load_outs do
    put :ship,:on => :member
    get :search,:on => :collection
  end


  resources :scan_header_local_town_load_ins

  resources :scan_header_inner_transit_load_outs do
    put :ship,:on => :member
    get :search,:on => :collection
  end

  resources :scan_header_inner_transit_load_ins

  resources :from_short_fee_infos do
    get :search,:on => :collection
    get :search_lines,:on => :collection
    get :report_lines,:on => :collection
    get :export_excel,:on => :member
    get :export_excel_for_kingdee,:on => :member
    #短途运费核销
    put :pass,:on => :member
    put :reject,:on => :member
    #生成凭证
    # get :build_accounting_document,:on => :member
  end

  resources :deposits

  resources :scan_header_load_outs do
    put :ship,:on => :member
    get :search,:on => :collection
  end

  resources :scan_header_load_ins do
    get :search,:on => :collection
  end
  resources :scan_header_teams do
    get :search,:on => :collection
    get :report_workload,:on => :collection
    get :export_excel,:on => :collection
  end

  resources :scan_header_sorting_ins

  resources :scan_headers

  resources :org_loads

  resources :org_sortings

  resources :region_divide_configs do
    get :get_config,:on => :collection
  end

  resources :regions

  resources :tasks do
    get :process_handle,:on => :member
    get :show_audit_page,:on => :member
    put :do_audit,:on => :member
    put :do_send,:on => :member
    get :search,:on => :collection
  end

  resources :own_tasks do
    get :process_handle,:on => :member
    get :new_progress_page,:on => :member
    put :save_progress,:on => :member
    get :show_finish_page,:on => :member
    put :save_finish,:on => :member
    get :search,:on => :collection
  end
 
  resources :single_vote_config_with_orgs do
    get :current_user_vote_index,:on => :collection
    get :new_vote,:on => :collection
    get :show_vote_info,:on => :member
    post :save_vote,:on => :collection
    get :show_sum,:on => :member
  end
  resources :price_tables
  resources :vote_config_with_orgs do
    get :current_user_vote_index,:on => :collection
    get :new_vote,:on => :collection
    get :show_vote_info,:on => :member
    post :save_vote,:on => :collection
    get :show_sum,:on => :member
  end

  resources :bill_notes,:only => :create
  resources :branch_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    get :export_excel_for_kingdee,:on => :collection

    put :invalidate,:on => :member
    put :cancel,:on => :member
  end

  resources :divide_configs do
    get :ton_volume_bill_divide_rate,:on => :collection
    get :branch_bill_divide_rate,:on => :collection
    get :search,:on => :collection
  end

  resources :ton_volume_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    get :export_excel_for_kingdee,:on => :collection
    put :invalidate,:on => :member
    put :print_counter,:on => :member
    put :cancel,:on => :member
  end

  resources :divide_lists do
    get :search,:on => :collection
  end

  resources :price_lists do
    get :price_line,:on => :collection
    get :search,:on => :collection
  end

  resources :fee_units

  resources :branch_customers do
    get :export_excel,:on => :collection
    get :search,:on => :collection
    get :query_for_bill_input,:on => :collection
  end

  mount ChinaCity::Engine => '/china_city'

  resources :address_books
  resources :short_fee_configs
  resources :deliver_regions

  #运费货款统计
  resources :rpt_from_org_mths do
    get :data,:on => :collection
    get :before_data_with_selected_mths,:on => :collection
  end

  resources :vote_configs do
    get :current_user_vote_index,:on => :collection
    get :new_vote,:on => :collection
    get :show_vote_info,:on => :member
    post :save_vote,:on => :collection
    get :show_sum,:on => :member
  end

  resources :carrying_fee_th_rpts do
    get :rpt_fenlichu,:on => :collection
    get :rpt_fengongsi,:on => :collection
    get :search_fenlichu,:on => :collection
    get :search_fengongsi,:on => :collection
    get :fenlichu_export_excel,:on => :collection
    get :fengongsi_export_excel,:on => :collection
  end

  resources :prepay_entries do
    get :search,:on => :collection
    get :export_excel,:on => :collection
  end

  resources :debt_bills do
    get :search,:on => :collection
    get :export_excel,:on => :member
  end

  resources :in_stock_bills do
    get :search,:on => :collection
    get :batch_input,:on => :collection
    get :export_excel,:on => :member
  end

  resources :adjust_fee_infos do
    put :pass,:on => :member
    put :deny,:on => :member
    put :re_submit,:on => :member
    get :show_operate_form,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :collection
  end

  resources :adjust_goods_fee_infos do
    put :pass,:on => :member
    put :deny,:on => :member
    put :re_submit,:on => :member
    get :show_operate_form,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :collection
  end

  resources :to_org_inner_transit_load_lists,:except => [:new,:create,:destroy] do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    post :export_sms_txt,:on => :member
    get :build_notice,:on => :member
    get :show_export_sms,:on => :member
    get :show_print_th_bill,:on => :member
    resources :carrying_bills
  end


  resources :transit_org_inner_transit_load_lists,:except => [:new,:create,:destroy] do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    post :export_sms_txt,:on => :member
    get :build_notice,:on => :member
    get :show_export_sms,:on => :member
    resources :carrying_bills
  end

  resources :from_org_inner_transit_load_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    post :export_sms_txt,:on => :member
    get :build_notice,:on => :member
    get :build_act_load_list,:on => :member
    get :show_export_sms,:on => :member
    resources :carrying_bills
  end

  resources :hand_inner_transit_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  resources :inner_transit_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  resources :local_town_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  resources :local_town_return_bills do
    get :before_new,:on => :collection
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  resources :hand_local_town_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end


  resources :yard_inventories do
    get :before_new,:on => :collection
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :search_bills,:on => :collection
    get :do_search_bills,:on => :collection
    put :process_handle,:on => :member
  end
  #分公司盘货确认
  resources :arrive_yard_inventories do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :before_check,:on => :member
    put :check,:on => :member
    get :export_sms_txt,:on => :member
  end


  resources :branch_inventories do
    get :before_new,:on => :collection
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :search_bills,:on => :collection
    get :do_search_bills,:on => :collection
    put :process_handle,:on => :member
 end

  #分理处盘货确认
  resources :arrive_branch_inventories do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :before_check,:on => :member
    put :check,:on => :member
  end


  resources :messages do
    put :update_view_count,:on => :member
    put :publish,:on => :member
    put :unpublish,:on => :member
    get :search,:on => :collection
  end
  resources :load_list_with_barcodes do
    put :confirm,:on => :member
  end

  resources :auto_calculate_computer_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    get :export_excel_for_kingdee,:on => :collection
    put :invalidate,:on => :member
    put :print_counter,:on => :member
    put :cancel,:on => :member
  end

  resources :goods_cat_fee_configs do
    get :single_config_line,:on => :collection
    get :show_batch_adjust,:on => :member
    get :export_excel,:on => :member
    get :copy_price,:on => :member
  end
  resources :notices do
    get :search,:on => :collection
    get :new_with_no_delivery,:on => :collection
  end

  resources :goods_cats

  resources :act_load_lists,:except => [:new] do
    get :search,:on => :collection
    get :export_excel,:on => :member
  end

  resources :goods_fee_settlement_lists do
    get :search,:on => :collection
    put :post,:on => :member
  end

  resources :notifies

  resources :areas

  resources :goods_errors do
    #显示核销界面
    get :show_authorize,:on => :member
    get :search,:on => :collection
  end

  resources :imported_customers do
    get :export_excel,:on => :collection
    get :search,:on => :collection
    get :fee_lines,:on => :member
    #按照客户卡号查询积分
    get :search_service_page_by_customer_code,:on => :collection
    get :search_service_by_customer_code,:on => :collection


  end

  resources :customer_fee_infos do
    get :search,:on => :collection
  end
  resources :customer_fee_info_lines,:only => :index do
    get :search,:on => :collection
  end


  resources :customer_level_configs

  resources :journals do
    get :search,:on => :collection
  end

  resources :remittances do
    get :search,:on => :collection
    #审核确认
    get :process_handle,:on => :member
  end

  resources :send_list_backs do
    get :search,:on => :collection
    get :export_excel,:on => :member
  end

  resources :send_list_posts do
    get :search,:on => :collection
    get :export_excel,:on => :member
  end

  resources :send_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
  end

  resources :senders

  resources :goods_exceptions do
    #显示授权核销界面
    get :show_authorize,:on => :member
    get :show_claim,:on => :member
    get :show_identify,:on => :member
    put :do_post,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :collection
  end

  resources :short_fee_infos do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_excel_for_kingdee,:on => :member
    #短途运费核销
    put :write_off,:on => :member
    #生成凭证
    get :build_accounting_document,:on => :member
  end

  resources :il_configs

  resources :config_cashes

  resources :config_transits

  resources :roles

  #将devise的url与model user产生的url区分开
  #参见https://github.com/plataformatec/devise/wiki/How-To:-Manage-users-through-a-CRUD-interface
  devise_for :users,:controllers => {:sessions => "sessions"}
  as :user do
    #登录成功后显示设置角色与部门界面
    match "new_session_default",:to => "sessions#new_session_default",:via => :get,:as => :user_root
    #保存用户设置
    match  "update_session_default",:to => "sessions#update_session_default",:via => :put,:as => :update_session_default
    match  "sign_in_mobile" => "sessions#sign_in_mobile",:via => :put,:as => :sign_in_mobile
  end

  resources :users do
    get :search,:on => :collection
    get :edit_password,:on => :collection
    get :reset_usb_pin,:on => :member
    put :update_password,:on => :collection
  end

  resources :transit_deliver_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  resources :transit_companies

  resources :transit_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  resources :base_post_infos do
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
    #生成凭证
    get :build_accounting_document,:on => :member

    #批量导出银行转账文本
    get :batch_export_with_bank,:on => :collection

    get :process_handle,:on => :member

  end

  resources :post_infos do
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
    #生成凭证
    get :build_accounting_document,:on => :member

    get :process_handle,:on => :member

    #批量导出银行转账文本
    get :batch_export_with_bank,:on => :collection
    #批量转账确认
    put :batch_transfer,:on => :collection


  end

  #同城快运-客户提款结算清单
  resources :local_town_post_infos do
    get :search,:on => :collection
    get :export_excel,:on => :member

    get :process_handle,:on => :member
    resources :carrying_bills
    #生成凭证
    get :build_accounting_document,:on => :member

    #批量导出银行转账文本
    get :batch_export_with_bank,:on => :collection
  end


  #内部中转-客户提款结算清单
  resources :inner_transit_post_infos do
    get :search,:on => :collection
    get :export_excel,:on => :member

    get :process_handle,:on => :member
    resources :carrying_bills
    #生成凭证
    get :build_accounting_document,:on => :member
    #批量导出银行转账文本
    get :batch_export_with_bank,:on => :collection
  end

  #外部中转-客户提款结算清单
  resources :outter_transit_post_infos do
    get :search,:on => :collection
    get :export_excel,:on => :member

    get :process_handle,:on => :member
    resources :carrying_bills
    #生成凭证
    get :build_accounting_document,:on => :member
    #批量导出银行转账文本
    get :batch_export_with_bank,:on => :collection
  end

  #客户提款-转账
  resources :base_cash_pay_infos do
    resources :carrying_bills
  end
  resources :base_transfer_pay_infos do
    resources :carrying_bills
  end


  #客户提款-转账
  resources :transfer_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  #同城快运-客户提款(转账)
  resources :local_town_transfer_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  #内部中转-转账支付
  resources :inner_transit_transfer_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  #外部中转-转账支付
  resources :outter_transit_transfer_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  #客户提款-现金
  resources :cash_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  #同城快运-客户提款(现金)
  resources :local_town_cash_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end


  #客户提款-内部中转
  resources :inner_transit_cash_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  #客户提款-外部中转
  resources :outter_transit_cash_pay_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  resources :payment_lists do
    resources :carrying_bills
  end


  resources :cash_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_txt,:on => :member
    resources :carrying_bills
  end

  #同城快运-货款支付清单
  resources :local_town_cash_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_txt,:on => :member
    resources :carrying_bills
  end

  #内部中转
  resources :inner_transit_cash_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_txt,:on => :member
    resources :carrying_bills
  end

  #外部中转
  resources :outter_transit_cash_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_txt,:on => :member
    resources :carrying_bills
  end

  resources :transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end
  resources :summary_org_transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end
  resources :summary_org_inner_transit_transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :summary_org_outter_transit_transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end


  resources :local_town_transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :summary_org_local_town_transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end



  resources :inner_transit_transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :outter_transit_transfer_payment_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_sms_excel,:on => :member
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :vips do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :syn_from_customer_name,:on => :member
    put :audit,:on => :member
  end

  resources :customers

  resources :banks

  resources :base_refunds do
    resources :carrying_bills
  end

  resources :refounds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end

  #同城快运-返款单
  resources :local_town_refunds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end

  #同城快运-返款清单确认
  resources :receive_local_town_refunds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end


  #外部中转-返款清单
  resources :outter_transit_refunds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end

  #外部中转-收款清单
  resources :receive_outter_transit_refunds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end



  #返款清单确认
  resources :receive_refounds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_excel_for_kingdee,:on => :collection
    resources :carrying_bills
  end
  resources :inner_transit_refund,:only => [:show]
  #中转返款单
  resources :from_org_inner_transit_refunds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end
  #中转返款单
  resources :transit_org_inner_transit_refunds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end
  #中转返款单
  resources :to_org_inner_transit_refunds do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end

  resources :base_settlements do
    resources :carrying_bills
  end

  #正常票据-结算员交款清单
  resources :settlements do
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :export_excel,:on => :member
    get :export_excel_for_kingdee,:on => :member
    #中转交款确认
    put :direct_refunded_confirmed,:on => :member
    #交款确认
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  #同城快运-结算员交款清单
  resources :local_town_settlements do
    get :search,:on => :collection
    get :export_excel,:on => :member
    #中转交款确认
    put :direct_refunded_confirmed,:on => :member
    #交款确认
    get :process_handle,:on => :member
    resources :carrying_bills
  end


  #外部中转结算员交款清单
  resources :outter_transit_settlements do
    get :search,:on => :collection
    get :export_excel,:on => :member
    #中转交款确认
    put :direct_refunded_confirmed,:on => :member
    #交款确认
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  #内部中转结算员交款清单
  resources :inner_transit_settlements do
    get :search,:on => :collection
    get :export_excel,:on => :member
    #中转交款确认
    put :direct_refunded_confirmed,:on => :member
    #交款确认
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :base_deliver_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  resources :deliver_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end

  #同城快运-提货
  resources :local_town_deliver_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end


  #内部中转提货
  resources :inner_transit_deliver_infos do
    get :search,:on => :collection
    resources :carrying_bills
  end


  resources :base_distribution_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end

  resources :distribution_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
    get :show_print_th_bill,:on => :member
  end
  #同城快运-分货清单
  resources :local_town_distribution_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end


  resources :inner_transit_distribution_lists do
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end

  resources :base_load_lists do
    resources :carrying_bills
  end
  #普通装车清单
  resources :load_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :build_act_load_list,:on => :member
    resources :carrying_bills
  end

  #外部中转装车清单
  resources :outter_transit_load_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    get :build_act_load_list,:on => :member
    resources :carrying_bills
  end


  resources :arrive_load_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    post :export_sms_txt,:on => :member
    get :build_notice,:on => :member
    get :show_export_sms,:on => :member
    get :show_print_th_bill,:on => :member
    resources :carrying_bills
  end

  resources :arrive_outter_transit_load_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    post :export_sms_txt,:on => :member
    get :show_export_sms,:on => :member
    get :show_print_th_bill,:on => :member
    resources :carrying_bills
  end

  #同城快运-货物装车清单
  resources :local_town_load_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    resources :carrying_bills
  end
  #同城快运-到货清单
  resources :arrive_local_town_load_lists do
    get :process_handle,:on => :member
    get :search,:on => :collection
    get :export_excel,:on => :member
    post :export_sms_txt,:on => :member
    get :build_notice,:on => :member
    get :show_export_sms,:on => :member
    get :show_print_th_bill,:on => :member
    resources :carrying_bills
  end

  resources :hand_transit_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
  end

  resources :transit_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  resources :hand_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    get :export_excel_for_kingdee,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
  end


  #正常运单退货
  resources :return_bills do
    get :before_new,:on => :collection
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  #外部中转运单-退货
  resources :outter_transit_return_bills do
    get :before_new,:on => :collection
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  #内部中转运单-退货
  resources :inner_transit_return_bills do
    get :before_new,:on => :collection
    get :search,:on => :collection
    get :export_excel,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end



  resources :orgs do
    get :show_org_permits,:on => :member
  end

  resources :branches
  resources :departments

  #添加carrying_biils路由
  resources :carrying_bills do
    get :rpt_turnover,:on => :collection
    get :rpt_turnover_by_org_load,:on => :collection
    get :rpt_turnover_for_refund,:on => :collection
    get :rpt_turnover_for_inner_transit_bill,:on => :collection
    get :rpt_no_delivery,:on => :collection
    post :rpt_branch_mc_1,:on => :collection
    post :rpt_branch_mc_2,:on => :collection
    get :rpt_branch_mc_1,:on => :collection
    get :rpt_branch_mc_2,:on => :collection

    get :turnover_chart,:on => :collection
    get :search,:on => :collection
    get :simple_search,:on => :collection
    get :simple_search_with_created_at,:on => :collection
    get :export_excel,:on => :collection
    get :export_excel_only_from_to_info,:on => :collection
    get :export_excel_for_kingdee,:on => :collection
    get :export_excel_transfer_payment_list_for_kingdee,:on => :collection
    get :export_sms_txt,:on => :collection
    post :export_sms_txt_for_rpt_no_pay,:on => :collection
    get :sum_goods_fee_inout,:on => :collection

    #多票查询
    get :search_service_page,:on => :collection
    get :search_service,:on => :collection

    #单票查询
    get :single_search_service_page,:on => :collection
    get :single_search_service,:on => :collection

    #按照客户卡号查询
    get :search_service_page_by_customer_code,:on => :collection
    get :search_service_by_customer_code,:on => :collection

    #分公司分成统计报表
    post :rpt_divide,:on => :collection
    get :rpt_divide,:on => :collection

    #分理处分成统计报表
    post :rpt_divide_department,:on => :collection
    get :rpt_divide_department,:on => :collection

    get :multi_bills_search,:on => :collection
    get :customer_code_search,:on => :collection
    #生成始发货现金付凭证
    get :build_accounting_document_from_cash,:on => :collection
    #始发货提付凭证
    get :build_accounting_document_from_th,:on => :collection
    #生成返程货物提付凭证
    get :build_accounting_document_to_th,:on => :collection
    #生成返程货现付凭证
    get :build_accounting_document_to_cash,:on => :collection

    #生成转账-代收货款支付清单凭证
    get :build_accounting_document_transfer_payment_list,:on => :collection

    put :reset,:on => :member
    put :invalidate,:on => :member
    put :cancel,:on => :member
    #提货单打印次数
    put :th_bill_print_counter,:on => :member
    #批量删除
    delete :batch_destroy,:on => :collection
    #始发收货汇总表
    get :rpt_turnover_by_from_org,:on => :collection

    #挂失
    put :report_loss,:on => :member

    #暂扣
    put :detain ,:on => :member
    #解除暂扣
    put :undetain ,:on => :member

    #货物异常信息
    get :barcode_exceptions,:on => :member
  end

  resources :computer_bills do
    get :search,:on => :collection
    get :export_excel,:on => :collection
    get :export_excel_for_kingdee,:on => :collection
    put :invalidate,:on => :member
    put :cancel,:on => :member
    put :print_counter,:on => :member
  end

  namespace :api do
    namespace :v1  do
      resources :tokens,:only => [:create, :destroy] do
        post :test_connect,:on => :collection
      end
      resource :dataset,:only => [] do
        post :search_read,:on => :member
        post :call_kw,:on => :member
      end
    end
  end

  root :to => "dashboard#index"
  mount ChinaCity::Engine => '/china_city'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end


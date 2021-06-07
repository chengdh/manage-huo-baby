# -*- encoding : utf-8 -*-
#定义运单soap相关
module CarryingBillExtend
  module Soap
    def self.included(base)
      base.class_eval do
        extend Savon::Model
        client wsdl: "http://218.28.172.7:9191/jdsmjg_shd/ws/expService?wsdl",
          env_namespace: :soapenv,
          namespaces: {
            #   "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
            #   "xmlns:cux" => "http://xmlns.oracle.com/apps/cux/soaprovider/plsql/cux_soa_app_getdata_pkg/",
            #   "xmlns:get" => "http://xmlns.oracle.com/apps/cux/soaprovider/plsql/cux_soa_app_getdata_pkg/get_soa_common_data/"
          },
          # wsse_auth: ["SOA", "welcome"],
          pretty_print_xml: true,
          log: true

          operations :fun_main
      end
      base.extend(ClassMethods)
    end

    #class methods
    module ClassMethods
      #获取表数据
      def fun_main(bill_hash)
        bill_hash = {
          :hydh => "10208455",
          :jjrxm => '苏秀花',
          :jjrlxdh => '13007698002',
          :jdwpmc => '袋子',
          :sjrxm => '志勇',
          :sjrlxdh => '13831956412',
          :sjrxz => '开封'
        }
        #企业编码:
        business_code = '02000000002177'
        #企业授权码
        license_code = '701F8FB12FCDDE10B4D1D7ABBE3FAC80'
        functioncode = '2001'
        params = {
          :functioncode => functioncode,
          :qybm => business_code,
          :qysqm => license_code,
          :sfxykh => 0
        }
        bill_hash.merge!(params)
        super(:message => { :arg0 => bill_hash.to_json})
      end
    end
  end
end

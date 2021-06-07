module CarryingBillExtend
  module UploadSoap
    def self.included(base)
      base.class_eval do
        extend ::Savon::Model
        # client wsdl: "http://218.28.172.7:9191/jdsmjg_shd/ws/expService?wsdl",
        client  wsdl: "http://www.jdsmjg.cn:9191/jdsmjg_shd/ws/expService?wsdl",
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
        #bill_hash = {
        #  :hydh => "10208455",
        #  :jjrxm => '苏秀花',
        #  :jjrlxdh => '13007698002',
        #  :jdwpmc => '袋子',
        #  :sjrxm => '志勇',
        #  :sjrlxdh => '13831956412',
        #  :sjrxz => '开封'
        #}
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

      def upload_bills(to_org_ids)
        bills = where(:bill_date => Date.today,:to_org_id => to_org_ids).search(:from_customer_id_is_not_null => true).relation.limit(Random.new.rand(300..600))
        bills.each do |b|
          bill_hash = {
            :hydh => b.bill_no,
            :jjrxm => b.from_customer_name,
            :jjrlxdh => b.from_customer_mobile,
            :jdwpmc => b.goods_info,
            :sjrxm => b.to_customer_name,
            :sjrlxdh => b.to_customer_mobile,
            :sjrxz => b.to_org.name
          }
          fun_main(bill_hash)
        end
      end
    end
  end
end

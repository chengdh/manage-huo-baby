#coding: utf-8

module CarryingBillExtend
  module UploadJson
    def self.included(base)
      base.class_eval do
      end
      base.extend(ClassMethods)
    end

    #class methods
    module ClassMethods
      # SERVER_URL = "http://www.jdsmjg.cn:9190/jdsmjgapi/api/v2/upload"
      # KEY = "BEF7824A98998D731169DC708B498CB3"
      # # 测试企业编码：
      # QYDM = "02000000001581"
      # # 测试网点编码：
      # WDDM = "02000000001581"



      # 企业编码：
      QYDM = "02000000002177"
      # 加密秘钥：
      KEY = "39AEEA689B51ED55B2349EF13649B39D"

      #分理处编码
      ORG_CODES = %w(
3
4
6
7
10
11
13
14
15
16
17
18
19
21
23
32
36
50
38
40
41
45
29
30
37
39
77
411
422
        )

        #公安系统编码
        EX_CODES = %w(
02000000002912
02000000002926
02000000002916
02000000007046
02000000002920
02000000002904
02000000002905
02000000002906
02000000002921
02000000002924
02000000007324
02000000002903
02000000002917
02000000002909
02000000002913
02000000002929
02000000008081
02000000002907
02000000006961
02000000002910
02000000002914
02000000002922
02000000002915
02000000006922
02000000002925
02000000002927
02000000011741
02000000011742
02000000010570
        )


      #上传运单数据
      def upload_bill(bill_hash)
        require "openssl"
        require "json"
        require "base64"

        server_url = "http://www.jdsmjg.cn:9191/jdsmjgapi/api/v2/upload"

        # bill_hash = {
        #   "qybm" => QYDM,
        #   "wdbm" => WDDM,
        #   "hydh" => "88010000001",
        #   "jjrzjlx" => "10",
        #   "jjrzjhm" => "410102198001011111",
        #   "sfrzm" => "",
        #   "jjrxm" => "张三",
        #   "jjrlxdh" => "13988888888",
        #   "hzgmsfhm" => "410104198301011112", 
        #   "hzxm" => "test",
        #   "jdwpmc" => "goods",
        #   "jdwpsl" => "10",
        #   "sjrxm" => "wangwu",
        #   "sjrgmsfhm" => "411327198301011113",
        #   "sjrlxdh" => "13677777777",
        #   "sjrxz" => "xxx road",
        #   "sjrszdq" => "410221",
        #   "ljrxm" => "name",
        #   "ljrgmsfhm" => "410104198801011114",
        #   "ljrq" => "20180101163020",
        #   "dtlx" => "1",
        #   "ljdz" => "road 65#",
        #   "ljdz_x" => "34.801251999999998",
        #   "ljdz_y" => "113.676815000000005"
        # }
        bill_str = bill_hash.to_json

        key1 = [KEY].pack('H*')
        cipher = OpenSSL::Cipher::AES.new(128, :CBC)
        cipher.encrypt  # set cipher to be encryption mode
        cipher.key = key1
        cipher.iv = key1

        encrypted = cipher.update(bill_str) + cipher.final
        result = Base64.encode64(encrypted).gsub(/\n/, '')
        form_data = {"qybm" => QYDM,
                     "data" => result}
        post_data(server_url,form_data)
      end

      #上传到货运单数据
      def upload_arrive_bill(bill_hash)
        require "openssl"
        require "json"
        require "base64"
        server_url = "http://www.jdsmjg.cn:9191/jdsmjgapi/api/v2/uploaddhxx"

        # bill_hash = {
        #   "qybm" => "02000000001581",
        #   "wdbm" =>  "02000000001581",
        #   "sfdbm" => "522322",
        #   "sfwdmc" => "XXX网点",
        #   "sjrszdq" => "410104",
        #   "hydh" => "88010000001",
        #   "jjrzjlx" => "10",
        #   "jjrzjhm" => "410102198001011111",
        #   "jjrxm" => "张三",
        #   "jjrlxdh" => "13988888888",
        #   "hzgmsfhm" => "410104198301011112",
        #   "hzxm" => "李四",
        #   "jdwpmc" => "农肥",
        #   "jdwpsl" => "10",
        #   "sjrxm" => "王五",
        #   "sjrgmsfhm" => "411327198301011113",
        #   "sjrlxdh" => "13677777777",
        #   "sjrxz" => "开封杞县 XX 路 XXX",
        #   "ljrxm" => "揽件人姓名",
        #   "ljrgmsfhm" => "410104198801011114",
        #   "ljrq" => "20180101163020",
        #   "thrq" => "20180104163020",
        #   "thrxm" => "王五",
        #   "thrgmsfhm" => "411327198301011113"
        # }

        bill_str = bill_hash.to_json

        key1 = [KEY].pack('H*')
        cipher = OpenSSL::Cipher::AES.new(128, :CBC)
        cipher.encrypt  # set cipher to be encryption mode
        cipher.key = key1
        cipher.iv = key1

        encrypted = cipher.update(bill_str) + cipher.final
        result = Base64.encode64(encrypted).gsub(/\n/, '')

        form_data = {"qybm" => QYDM,
                     "data" => result}
        resp = post_data(server_url,form_data)
        resp.body
      end

      def batch_upload_bills
        org_ids = Org.where(:code => ORG_CODES).pluck(:id)
        #merge org_code and ex_codes to hash
        the_hash = {}
        org_ids.each_with_index {|o_id,i| the_hash[o_id] = EX_CODES[i] }
        bills = where(:bill_date => Date.today,:from_org_id => org_ids).search(:from_customer_id_is_not_null => true) #.relation.limit(Random.new.rand(300..600))
        bills.each do |b|
          bill_hash = {
            "qybm" => QYDM,
            "wdbm" => the_hash[b.from_org_id],
            "hydh" => b.bill_no,
            "jjrzjlx" => "10",
            "jjrzjhm" => b.from_customer.try(:id_number),
            "sfrzm" => "",
            "jjrxm" => b.from_customer_name,
            "jjrlxdh" => b.from_customer_mobile,
            "hzgmsfhm" => "",
            "hzxm" => "",
            "jdwpmc" => b.goods_info,
            "jdwpsl" => b.goods_num,
            "sjrxm" => b.to_customer_name,
            "sjrgmsfhm" => "",
            "sjrlxdh" => b.to_customer_mobile,
            "sjrxz" => "",
            "sjrszdq" => "410221",
            "ljrxm" => b.user.real_name,
            "ljrgmsfhm" => "",
            "ljrq" => b.created_at.strftime("%Y%m%d%H%M%S"),
            "dtlx" => "1",
            "ljdz" => "",
            "ljdz_x" => "",
            "ljdz_y" => ""
          }
          upload_bill(bill_hash)
        end
      end

      #批量上传到货信息
      def batch_upload_arrive_bills
        org_ids = Org.where(:code => ORG_CODES).pluck(:id)
        #merge org_code and ex_codes to hash
        the_hash = {}
        org_ids.each_with_index {|o_id,i| the_hash[o_id] = EX_CODES[i] }
        bills = where(:from_org_id => org_ids).search(:deliver_info_deliver_date_eq => Date.today,:from_customer_id_is_not_null => true) #.relation.limit(Random.new.rand(300..600))
        bills.each do |b|
          bill_hash = {
            "qybm" => QYDM,
            "wdbm" => the_hash[b.from_org_id],
            "sfdbm" => "522322",
            "sfwdmc" => b.from_org.name,
            "sjrszdq" => "410104",
            "hydh" => b.bill_no,
            "jjrzjlx" => "10",
            "jjrzjhm" => b.from_customer.try(:id_number),
            "jjrxm" => b.from_customer_name,
            "jjrlxdh" => b.from_customer_mobile,
            "hzgmsfhm" => "",
            "hzxm" => "",
            "jdwpmc" => b.goods_info,
            "jdwpsl" => b.goods_num,
            "sjrxm" => b.to_customer_name,
            "sjrgmsfhm" => "",
            "sjrlxdh" => b.to_customer_mobile,
            "sjrxz" => "",
            "ljrxm" => b.user.real_name,
            "ljrgmsfhm" => "",
            "ljrq" => b.created_at.strftime("%Y%m%d%H%M%S"),
            "thrq" => b.try(:deliver_info).try(:created_at).try(:strftime,"%Y%m%d%H%M%S"),
            "thrxm" =>  b.try(:deliver_info).try(:customer_name),
            "thrgmsfhm" => ""
          }

          upload_arrive_bill(bill_hash)
        end
      end

      def post_data(server_url,form_data)
        require "net/http"
        require "uri"
        uri = URI.parse(server_url)

        # Shortcut
        response = Net::HTTP.post_form(uri, form_data)
      end
    end
  end
end

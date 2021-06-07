# -*- encoding : utf-8 -*-
#coding: utf-8
#本类实现汉字转拼音功能，由perl的Lingua::Han::PinYin包port而来(包括UniHan的数据)。
#
#由于实际需要只实现utf-8版本，需要gbk等转拼音的请使用Iconv自行转换。
# 
#感谢Lingua::Han::PinYin原作者(http://www.fayland.org/journal/Han-PinYin.html)的工作.
#
#Author::    H.J.Leochen ( http://www.upulife.com )
#License::   Distributes under the same terms as Ruby

require 'singleton'
class PinYin
	#OK,单例。
	include Singleton

	#单例模式，使用 PinYin.instance 实例。
	def initialize
		fn = File.join(File.dirname(File.expand_path(__FILE__)),'dict/Mandarin.dat')
		@codes = {}
		File.readlines(fn).each do |line|
			nv = line.split(/\s/)
			@codes[nv[0]] = nv[1]
		end
	end

	#permlink固定分隔符,
	#结果样式：Interesting-Ruby-Tidbits-That-Dont-Need-Separate-Posts-17
	#
	def to_permlink(str)
		str_to_pinyin(str,'-')
	end

	#全部取首字母。 eg. ldh 刘德华
	def to_pinyin_abbr(str)
		str_to_pinyin(str,'',false,true)
	end

	#第一个字取全部，后面首字母.名称缩写。eg. liudh 刘德华
	def to_pinyin_abbr_else(str)
		str_to_pinyin(str,'',true,nil) #后面那个参数已经没有影响了。
	end

	#通用情况 tone为取第几声的标识。eg. ni3hao3zhong1guo2
	def to_pinyin(str,separator='',tone=false)
		str_to_pinyin(str,separator,false,false,tone)
	end

	private

	def get_value(code)
		@codes[code]
	end

	def str_to_pinyin(str,separator='',abbr_else=false,abbr=false,tone=false)
		res = []
		str.unpack('U*').each_with_index do |t,idx|
			code = sprintf('%x',t).upcase
			val = get_value(code)
			#是否找到拼音？
			if val
				unless tone
					val = val.gsub(/\d/,'')
				end
				if (abbr and !abbr_else) or (abbr_else and idx!=0)
					val = val[0..0]
				end
				res << val.downcase+separator
			else
				tmp = [t].pack('U*')
				res << tmp if tmp =~ /^[_0-9a-zA-Z\s]*$/ #复原，去除特殊字符,如全角符号等。
				##???? 为什么 \W 不行呢？非要用0-9a-zA-Z呢？
			end
		end
		unless separator==''
			re = Regexp.new("\\#{separator}+")
			re2 = Regexp.new("\\#{separator}$")
			return res.join('').gsub(/\s+/,separator).gsub(re,separator).gsub(re2,'')
		else
			return res.join('')
		end
	end
end



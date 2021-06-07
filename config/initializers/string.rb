# -*- encoding : utf-8 -*-
#为String类添加一些方法
class String
  def utf8_to_gb2321
    encode_convert(self, "gb2321", "UTF-8")
  end

  def gb2321_to_utf8
    encode_convert(self, "UTF-8", "gb2321")
  end

  def utf8_to_utf16
    encode_convert(self, "UTF-16LE", "UTF-8")
  end

  def utf8?
    begin
      utf8_arr = self.unpack('U*')
      true if utf8_arr && utf8_arr.size > 0
    rescue
      false
    end
  end

  private
  def encode_convert(s, to, from)
    require 'iconv'
    begin
      converter = Iconv.new("#{to}//IGNORE", "#{from}//IGNORE")
      converter.iconv(s)
    rescue
      s
    end
  end
end

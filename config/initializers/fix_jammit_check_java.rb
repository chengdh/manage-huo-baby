#coding: utf-8
#修正在中文windows系统下,ruby1.9环境下,未安装java时的问题
module Jammit
  # The YUI Compressor requires Java > 1.4, and Closure requires Java > 1.6.
  def self.check_java_version
    return true if @checked_java_version
    java = @compressor_options[:java] || 'java'
    @css_compressor_options[:java] ||= java if @compressor_options[:java]
    version = nil
    version = (`#{java} -version 2>&1`)[/\d+\.\d+/] if system('java -version')

    disable_compression if !version ||
      (@javascript_compressor == :closure && version < '1.6') ||
      (@javascript_compressor == :yui && version < '1.4')
    @checked_java_version = true
  end
end

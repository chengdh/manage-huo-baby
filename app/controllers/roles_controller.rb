# -*- encoding : utf-8 -*-
#coding: utf-8
class RolesController < BaseController
  #缓存(此处是http-cache)用户修改页面
  # http_cache :edit,:last_modified => Proc.new {|c| c.send(:last_modified)},:etag => Proc.new {|c| c.send(:etag,"role_edit")}
  # http_cache :new,:last_modified => Proc.new {|c| c.send(:last_modified)},:etag => Proc.new {|c| c.send(:etag,"role_new")}

  def new
    @role = Role.new_with_default
  end
end

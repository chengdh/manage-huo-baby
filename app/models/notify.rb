# -*- encoding : utf-8 -*-
class Notify < ActiveRecord::Base
  belongs_to :user
  def self.current_notify_text
    notify = self.last
    nil unless notify
    notify.notify_text if notify
  end
end

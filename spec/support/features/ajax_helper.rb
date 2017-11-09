# https://github.com/nasa/mmt/blob/master/spec/support/ajax_helper.rb

module Helpers
  module AjaxHelpers
    def wait_for_ajax
      still_working = true
      while still_working
        if still_working = page.driver.network_traffic.collect(&:response_parts).any?(&:empty?)
          sleep 0.1
        end
      end
    end
  end
end

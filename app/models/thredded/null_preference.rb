# frozen_string_literal: true
module Thredded
  class NullPreference
    def notify_on_mention # override default to be false
      false
    end

    def notify_on_message
      false
    end
  end
end
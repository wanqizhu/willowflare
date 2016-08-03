require_dependency File.expand_path('../../app/models/thredded/post', Thredded::Engine.called_from)

module Thredded
  class Post # reopen
    def autofollow_and_notify
      #no-op
    end
  end
end
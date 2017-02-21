require_dependency File.expand_path('../../app/models/thredded/post', Thredded::Engine.called_from)

module Thredded
  class Post # reopen

  	# # carrier_wave uploader
  	mount_uploaders :images, ImagesUploader
  	serialize :images, Array # make it into an array (equiv. to JSON, but sqlite3 doesn't support JSON types
  	# so we can upload multiple images

    def autofollow_and_notify
      #no-op
    end
  end
end
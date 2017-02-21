require_dependency File.expand_path('../../app/models/thredded/topic', Thredded::Engine.called_from)

module Thredded
  class Topic # reopen

  	# # carrier_wave uploader
  	# see post.rb Model
  	mount_uploaders :images, ImagesUploader
  	serialize :images, Array

  end
end
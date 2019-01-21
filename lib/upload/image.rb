# frozen_string_literal: true

require 'action_dispatch'
module Upload
  class Image < ActionDispatch::Http::UploadedFile
    def initialize(tempfile)
      super(tempfile: tempfile, filename: tempfile.name, original_filename: tempfile.name)
    end
  end
end

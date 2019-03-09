# frozen_string_literal: true

require 'tempfile'
require 'upload/image'
module Upload
  class Cache < Tempfile
    attr_reader :name
    def initialize(picture)
      super('fileupload')
      binmode
      write(Base64.decode64(picture[:file]))
      @name = picture[:name]
    end
  end
end

# frozen_string_literal: true

require "pdf/reader"
require "stringio"

module DataExtraction
  class Pdf
    def self.extract(attachment)
      raise ArgumentError, "No attachment" unless attachment&.attached?
      raise ArgumentError, "Not a PDF" unless attachment.content_type == "application/pdf"

      io = StringIO.new(attachment.download)
      reader = PDF::Reader.new(io)

      # Combine text from all pages
      reader.pages.map(&:text).join("\n\n")
    end
  end
end
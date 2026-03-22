class DocumentChunk < ApplicationRecord
  belongs_to :document
  validates :content, presence: true
end

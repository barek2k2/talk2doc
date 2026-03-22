class Document < ApplicationRecord
  has_many :document_chunks, dependent: :destroy
  has_one_attached :attachment

  validates :title, presence: true

  after_commit :extract_and_chunk, only: [:create, :update]

  def extract_and_chunk
    return unless attachment.attached?
    return unless attachment.content_type == "application/pdf"
    extracted = ::DataExtraction::Pdf.extract(attachment)
    update_column(:content, extracted) if content.to_s.strip.empty?
    LLM::DocumentIngestService.new.ingest!(title: self.title, content: self.content,document: self)
  end

end
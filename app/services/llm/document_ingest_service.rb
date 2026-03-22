module LLM
  class DocumentIngestService
    def initialize(embedder: LLM::EmbeddingService.new)
      @embedder = embedder
    end

    def ingest!(title:, content:, document:)
      chunks = LLM::ChunkingService.new(content).chunks
      raise ArgumentError, "No chunks produced" if chunks.empty?

      chunks.each_with_index do |chunk, idx|
        DocumentChunk.create!(
          document: document,
          chunk_index: idx,
          content: chunk,
          embedding: @embedder.embed(chunk)
        )
      end
    end
  end
end

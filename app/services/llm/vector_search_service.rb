module LLM
  class VectorSearchService
    def initialize(embedder: LLM::EmbeddingService.new)
      @embedder = embedder
    end

    def search(query:, limit: 5)
      qvec = @embedder.embed(query)
      qlit = LLM::VectorSql.literal(qvec)

      DocumentChunk
        .includes(:document)
        .order(Arel.sql("embedding <-> '#{qlit}'"))
        .limit(limit)
    end
  end
end

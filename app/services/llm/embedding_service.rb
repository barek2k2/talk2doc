module LLM
  class EmbeddingService < LLM::Config
    def embed(text)
      raise ArgumentError, "text is empty" if text.to_s.strip.empty?

      uri = URI("#{OLLAMA_URL}/api/embeddings")
      req = Net::HTTP::Post.new(uri)
      req["Content-Type"] = "application/json"
      req.body = { model: EMBED_MODEL, prompt: text }.to_json

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
      raise "Ollama error: #{res.code} #{res.body}" unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body).fetch("embedding")
    end
  end
end

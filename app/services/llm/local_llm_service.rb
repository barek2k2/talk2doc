module LLM

  class LocalLLMService < LLM::Config
    def answer(question:, chunks:)
      context = chunks.map.with_index(1) do |c, i|
        <<~TXT
      [Source #{i}] (#{c.document.title} :: chunk #{c.chunk_index})
      #{c.content}
        TXT
      end.join("\n\n")

      prompt = <<~PROMPT
    You are a helpful assistant. Answer the question using ONLY the provided sources.
    If the sources do not contain the answer, say: "I don't know based on the knowledge provided."

    Question:
    #{question}

    Sources:
    #{context}

    Answer:
      PROMPT

      generate(prompt)
    end

    private

    def generate(prompt)
      uri = URI("#{OLLAMA_URL}/api/generate")
      req = Net::HTTP::Post.new(uri)
      req["Content-Type"] = "application/json"
      req.body = {
        model: CHAT_MODEL,
        prompt: prompt,
        stream: false
      }.to_json

      res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
      raise "Ollama error: #{res.code} #{res.body}" unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body).fetch("response")
    end
  end
end


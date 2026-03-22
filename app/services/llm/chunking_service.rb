module LLM
  class ChunkingService < LLM::Config

    def initialize(text, words: DEFAULT_WORDS, overlap: DEFAULT_OVERLAP)
      @text = text.to_s
      @words = words
      @overlap = overlap
    end

    def chunks
      words = @text.split
      return [] if words.empty?

      out = []
      i = 0
      step = [@words - @overlap, 1].max

      while i < words.length
        out << words[i, @words].join(" ")
        i += step
      end

      out
    end
  end
end

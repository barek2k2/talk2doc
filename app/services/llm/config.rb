module LLM
  require "net/http"
  require "json"

  class Config
    OLLAMA_URL   = ENV.fetch("OLLAMA_URL", "http://localhost:11434")
    CHAT_MODEL   = ENV.fetch("OLLAMA_CHAT_MODEL",  "gemma2:9b")
    EMBED_MODEL  = ENV.fetch("OLLAMA_EMBED_MODEL", "nomic-embed-text:latest")

    DEFAULT_WORDS   = 800
    DEFAULT_OVERLAP = 120
  end
end
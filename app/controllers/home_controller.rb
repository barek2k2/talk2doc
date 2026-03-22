class HomeController < ApplicationController
  def index
  end

  def search
    query = params[:q]
    @top_chunks = LLM::VectorSearchService.new.search(query: query,limit: 2)

    answer = LLM::LocalLLMService.new.answer(
      question: query,
      chunks: @top_chunks
    )

    @answer = {
      ok: true,
      query: query,
      answer: answer,
      sources: @top_chunks.map { |c|
        { document_id: c.document_id, title: c.document.title, chunk_index: c.chunk_index }
      }
    }

    render "index"

  end
end

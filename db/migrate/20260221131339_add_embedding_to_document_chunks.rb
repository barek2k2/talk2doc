class AddEmbeddingToDocumentChunks < ActiveRecord::Migration[8.1]
  def up
    add_column :document_chunks, :embedding, :vector, limit: 768
  end

  def down
    remove_column :document_chunks, :embedding
  end
end

module LLM
  module VectorSql
    def self.literal(arr)
      "[" + arr.map { |x| Float(x) }.join(",") + "]"
    end
  end
end

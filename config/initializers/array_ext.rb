Array.class_eval do
  def my_hash
    hash = {}
    each_with_index do |item, idx|
      hash[idx.to_s] = item
    end
    hash
  end
end

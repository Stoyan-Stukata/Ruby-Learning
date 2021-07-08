class ArrayStore
  attr_accessor :storage

  def initialize
    @storage = []
  end

  def create(query_object)
    storage.push(query_object)
  end

  def find(query_filter)
    storage.select { |item| query_filter.all? { |field, value| item[field] == value } }
  end

  def update(id, query_update)
    storage[id].update(query_update)
  end

  def delete(query_filter)
    storage.filter { |item| item != query_filter }
  end
end

class HashStore
  attr_accessor :storage

  def initialize
    @storage = {}
  end

  def create(query_object)
    storage[query_object[id]] = query_object
  end

  def find(query_filter)
    storage.values.select { |item| query_filter.all? { |field, value| item[field] == value } }
  end

  def update(id, query_update)
    storage[id].update(query_update)
  end
end

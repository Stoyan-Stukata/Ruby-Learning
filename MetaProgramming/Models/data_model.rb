class DataModel
  attr_accessor :attributes, :data_store

  class << self
    def attributes(*attributes)
      @attributes = attributes
    end

    def data_store(data_store)
      @data_store = data_store
    end

    def where(query_filter)
      data_store.find(query_filter)
    end
  end
end

class DataModel
  attr_accessor :attributes, :data_store

  class << self
    def attributes(*attributes)
      define_method 'attributes' do
        attributes
      end
    end

    def data_store(data_store)
      define_method 'data_store' do
        data_store
      end
    end

    def where(query_filter)
      data_store.find(query_filter)
    end
  end
end

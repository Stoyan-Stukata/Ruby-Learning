require_relative 'data_model'
require_relative '../Storages/array_store'

class UserModel < DataModel
  attributes :name, :email
  data_store ArrayStore.new

  def initialize(user = {})
    super()

    p attributes

    @saved = false
    @instance_values = user.select { |field, _| attributes.any? { |attribute| attribute.to_s == field } }
  end

  def save
    # query_object = @instance_values.merge id: id
    if data_store.find(query_object).empty?
      data_store.create query_object
    else
      data_store.update query_object
    end

    @saved = true
    # id = id + 1
    self
  end

  def delete
    raise ModelError, 'Current instance was never saved!' unless @saved

    @data_store.delete @instance_values
  end
end

# UserModel.new({ name: "stoyan" }).save
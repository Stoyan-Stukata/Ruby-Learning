require_relative './Models/user_model'

p UserModel.new({ name: 'Stoyan', email: 'sgrozdanov@asteasolutions.com' })
# p UserModel.new
UserModel.where({ name: 'Stoyan' })
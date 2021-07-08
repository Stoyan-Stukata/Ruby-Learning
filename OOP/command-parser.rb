class CommandParser
  def initialize(command_name)
    @name = command_name
    @arguments = []
    @options = {}
  end

  def argument(argument_name, &block)
    @arguments.push(Argument.new(argument_name, block))
  end

  def option(short_name, full_name, description, &block)
    option = Option.new(short_name, full_name, description, block)

    @options[short_name] = option
    @options[full_name] = option
  end

  def option_with_parameter(short_name, full_name, description, parameter_name, &block)
    option = OptionWithParameter.new(short_name, full_name, description, block, parameter_name)

    @options[short_name] = option
    @options[full_name] = option
  end

  def parse(anchor_object, values)
    arguments = @arguments.dup

    values.each do |value|
      if value.start_with? '-'
        option, parameter = value.split('=', 2)
        option_block = @options[option.delete('-')]&.block

        parameter ? option_block&.call(anchor_object, parameter) : option_block&.call(anchor_object, value)
      else
        arguments.shift.block.call(anchor_object, value)
      end
    end
  end

  def help
    "Usage: #{@name} #{@arguments.map { |argument| "[#{argument.name}]" }.reduce { |a, b| "#{a} #{b}" }} \n" \
    "#{
      options = @options.map do |_, option|
        option_inspect = "    -#{option.short_name}, --#{option.full_name}"
        option_inspect += "=#{option.parameter_name}" if option.is_a? OptionWithParameter
        "#{option_inspect} #{option.description}"
      end

      options.uniq.reduce { |a, b| "#{a}\n#{b}" }
    }"
  end
end

class Argument
  attr_reader :name, :block

  def initialize(name, block)
    @name = name
    @block = block
  end
end

class Option
  attr_reader :short_name, :full_name, :description, :block

  def initialize(short_name, full_name, description, block)
    @short_name = short_name
    @full_name = full_name
    @description = description
    @block = block
  end
end

class OptionWithParameter < Option
  attr_reader :parameter_name

  def initialize(*option_args, parameter_name)
    super(*option_args)
    @parameter_name = parameter_name
  end
end

def main
  cmd = CommandParser.new('grep')

  cmd_object = {}

  cmd.argument('READ_FILE') do |object, value|
    object[:read_file] = value
  end

  cmd.argument('WRITE_FILE') do |object, value|
    object[:write_file] = value
  end

  cmd.option('v', 'version', 'show version number') do |object, value|
    object[:version] = value
  end

  cmd.option_with_parameter('r', 'require', 'require FILE in spec', 'FILE') do |object, value|
    object[:require] = value
  end

  cmd.parse(cmd_object, ['command-parser.rb', 'output.ts', '--version', '--require=grep.sh'])
  p cmd_object

  puts cmd.help
end

main

require_relative "context"
require_relative "command"

class ALU
  attr_accessor :context, :commands
  def initialize(filename)
    self.commands = load_commands_from_file(filename)
  end

  def load_commands_from_file(filename)
    File.readlines(filename).map do |line|
      Command.new(text: line)
    end
  end

  def run(input)
    self.context = Context.new(input)
    commands.each do |command|
      command.execute(context)
    end
  end
end

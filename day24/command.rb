class Command
  attr_accessor :action, :first_param, :second_param, :context
  def initialize(text:)
    details = text.split
    self.action = details[0]
    self.first_param = details[1]
    self.second_param = details[2] unless action == "inp"
  end

  def execute(context)
    self.context = context
    send(action)
  end

  def inp
    set_output(context.input.shift.to_i)
  end

  def add
    set_output(first_param_value + second_param_value)
  end

  def mul
    set_output(first_param_value * second_param_value)
  end

  def div
    set_output(first_param_value.div(second_param_value))
  end

  def mod
    set_output(first_param_value % second_param_value)
  end

  def eql
    set_output(first_param_value == second_param_value ? 1 : 0)
  end

  def set_output(value)
    context.send("#{first_param}=", value)
  end

  def first_param_value
    first_param.to_i.to_s == first_param ? first_param.to_i : context.send(first_param)
  end

  def second_param_value
    second_param.to_i.to_s == second_param ? second_param.to_i : context.send(second_param)
  end
end

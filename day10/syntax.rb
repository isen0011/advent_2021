class Syntax
  START_CHUNK_SYMBOLS = ["(", "[", "{", "<"].freeze

  MATCHING_END_SYMBOL = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }.freeze

  attr_accessor :code_lines
  def initialize(filename)
    self.code_lines = File.readlines(filename).map(&:strip)
  end

  def total_score
    code_line_errors.map{ |error| error_score(error) }.sum
  end

  def autocomp_score
    hold_scores = code_autocomp_scores.sort
    puts "scores are: #{hold_scores}"
    hold_scores[hold_scores.length / 2]
  end

  def code_autocomp_scores
    code_lines.map {|line| parse_autocomp(line) }.reject {|score| score == -1 }
  end

  def code_line_errors
    code_lines.map {|line| parse_line(line) }
  end

  def parse_autocomp(line)
    # puts "examining line #{line}"
    start_symbol_stack = []
    line.each_char do |char|
      if START_CHUNK_SYMBOLS.include?(char)
        # puts "- #{char}: start symbol, adding to stack #{start_symbol_stack}"
        start_symbol_stack.push(char)
      else
        start_symbol = start_symbol_stack.pop
        if char != MATCHING_END_SYMBOL[start_symbol]
          # puts "** #{char}: doesn't match expected end symbol #{start_symbol} exiting!"
          return -1
        end
      end
    end
    # puts "scoring #{start_symbol_stack}"
    score_completion_string(start_symbol_stack)
  end

  def score_completion_string(stack)
    stack.reverse.inject(0) do |score, symbol|
      score = score * 5 + start_symbol_score(symbol)
    end
  end

  def start_symbol_score(symbol)
    START_CHUNK_SYMBOLS.index(symbol) + 1
  end

  def parse_line(line)
    # puts "examining line #{line}"
    start_symbol_stack = []
    line.each_char do |char|
      if START_CHUNK_SYMBOLS.include?(char)
        # puts "- #{char}: start symbol, adding to stack #{start_symbol_stack}"
        start_symbol_stack.push(char)
      else
        start_symbol = start_symbol_stack.pop
        if char != MATCHING_END_SYMBOL[start_symbol]
          # puts "** #{char}: doesn't match expected end symbol #{start_symbol} exiting!"
          return char
        end
      end
    end
  end

  def error_score(error_code)
    case error_code
    when ")"
      3
    when "]"
      57
    when "}"
      1197
    when ">"
      25137
    else
      0
    end
  end
end

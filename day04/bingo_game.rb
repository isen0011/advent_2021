class BingoGame
  class BingoBoard
    attr_accessor :numbers, :mark_list

    def initialize(board_string)
      self.numbers = board_string.map(&:strip).join(" ").split.map(&:to_i)
      self.mark_list = Array.new(numbers.length, false)
    end

    def unmarked_score
      numbers.each_with_index.inject(0) { |sum, (number, i)| !mark_list[i] ? sum + number : sum }
    end

    def mark_number(number)
      if numbers.include?(number)
        mark_list[numbers.index(number)] = true
      end
    end

    def to_s
      "#{numbers.join("-")} / #{mark_list.join("-")}"
    end

    def won?
      mark_rows.any? { |row| row.all? { |mark| mark } } ||
        mark_columns.any? { |column| column.all? { |mark| mark } }
    end

    def mark_rows
      row_indexes.map { |row| row.map { |index| mark_list[index] } }
    end

    def mark_columns
      column_indexes.map { |column| column.map { |index| mark_list[index] } }
    end

    def row_indexes
      [(0..4).to_a, (5..9).to_a, (10..14).to_a, (15..19).to_a, (20..24).to_a]
    end

    def column_indexes
      [[0,5,10,15,20],[1,6,11,16,21],[2,7,12,17,22],[3,8,13,18,23],[4,9,14,19,24]]
    end
  end

  attr_reader :called_numbers, :boards

  def initialize(filename)
    filedata = File.readlines(filename)
    self.called_numbers = load_called_numbers(filedata.shift)
    self.boards = load_boards(filedata)
    self.last_number_called = nil
  end

  def winner
    @winner ||= get_winner
  end

  def get_winner
    play_called_numbers
    boards.find { |board| !board.won? }
  end

  def winner?
    boards.all? { |board| board.won? }
  end

  def score
    winner
    not_winning_boards.unmarked_score * last_number_called
  end

  private

  attr_writer :called_numbers, :boards
  attr_accessor :last_number_called, :not_winning_boards

  def play_called_numbers
    called_numbers.each do |number|
      self.last_number_called = number
      mark_number_on_boards(number)
      puts "marked #{last_number_called}.  W: #{winner?}"
      break if winner?
      self.not_winning_boards = boards.find { |board| !board.won? }
    end
  end

  def mark_number_on_boards(number)
    boards.each { |board| board.mark_number(number) }
  end

  def load_called_numbers(line)
    line.split(",").map(&:to_i)
  end

  def load_boards(filedata)
    filedata.each_slice(6).to_a.map { |board_string| BingoBoard.new(board_string) }
  end
end

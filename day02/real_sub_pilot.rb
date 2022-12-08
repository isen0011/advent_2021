class SubPilot
  class Move
    class Position
      attr_accessor :horizontal, :vertical, :aim
      def initialize(h: 0, v: 0, a: 0)
        self.horizontal = h
        self.vertical = v
        self.aim = a
      end

      private

      attr_writer :horizontal, :vertical, :aim
    end

    attr_accessor :direction, :distance
    def initialize(line)
      self.direction = line.split.first
      self.distance = line.split.last.to_i
    end

    def make_move(sl)
      case direction
      when "up"
        Position.new(h: sl.horizontal, v: sl.vertical, a: sl.aim - distance)
      when "down"
        Position.new(h: sl.horizontal, v: sl.vertical, a: sl.aim + distance)
      when "forward"
        Position.new(h: sl.horizontal + distance,
                    v: sl.vertical + sl.aim * distance,
                    a: sl.aim)
      end
    end
  end

  def initialize(filename)
    self.filename = filename
    self.final_position = run_moves
  end

  def horizontal
    final_position.horizontal
  end

  def vertical
    final_position.vertical
  end

  private

  def run_moves
    moves.inject(Move::Position.new) do |curr_loc, move|
      move.make_move(curr_loc)
    end
  end

  def moves
    @moves ||= read_moves_from_file
  end

  def read_moves_from_file
    File.readlines(filename).map(&:strip).map {|line| Move.new(line)}
  end

  attr_accessor :filename, :final_position
end

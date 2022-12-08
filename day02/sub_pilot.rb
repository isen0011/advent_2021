class SubPilot
  class Move
    attr_accessor :direction, :distance
    def initialize(line)
      self.direction = line.split.first
      self.distance = line.split.last.to_i
    end

    def horizontal?
      self.direction == "forward"
    end

    def vertical?
      self.direction == "up" || self.direction == "down"
    end

    def adjusted_distance
      if self.direction == "up"
        self.distance * -1
      else
        self.distance
      end
    end
  end

  attr_reader :horizontal, :vertical

  def initialize(filename)
    self.filename = filename
    run_moves
  end

  private

  attr_writer :horizontal, :vertical

  def run_moves
  end

  def horizontal_moves
    moves.select {|move| move.horizontal? }
  end

  def vertical_moves
    moves.select {|move| move.vertical? }
  end

  def moves
    @moves ||= read_moves_from_file
  end

  def read_moves_from_file
    File.readlines(filename).map(&:strip).map {|line| Move.new(line)}
  end

  attr_accessor :filename
end

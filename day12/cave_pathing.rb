class CavePathing
  attr_accessor :unfinished_paths, :cave_connections, :finished_paths

  def initialize(filename)
    self.cave_connections = Hash.new
    load_connections_from_file(filename)
    self.unfinished_paths = create_start_path
    self.finished_paths = []
    find_all_paths
  end

  def create_start_path
    [CavePath.new(current_cave: "start", cave_map: cave_connections)]
  end

  def find_all_paths
    cycles = 0
    while unfinished_paths.count > 0
      # puts "*** cycle: #{cycles}, current paths:\n--#{unfinished_paths.join("\n--")}"
      test_path = unfinished_paths.shift
      if test_path.finished?
        finished_paths.push(test_path)
        # puts "*finished paths: #{finished_paths.join("\n")}**"
      else
        unfinished_paths.push(*test_path.next_steps)
      end
      cycles += 1
    end
  end

  def load_connections_from_file(filename)
    File.readlines(filename).map(&:strip).each do |line|
      (start,stop) = line.split("-")
      cave_connections[start] = Array.new unless cave_connections.has_key?(start)
      cave_connections[start].push(stop)
      cave_connections[stop] = Array.new unless cave_connections.has_key?(stop)
      cave_connections[stop].push(start)
    end
    puts "loaded connections #{cave_connections.keys}"
  end

  def path_list
    finished_paths.map(&:to_s).sort.join("\n")
  end

  class CavePath
    attr_accessor :location, :path, :cave_map
    def initialize(current_cave:, cave_map:, previous_path: [])
      self.location = current_cave
      self.path = previous_path.clone
      path.push(location)
      self.cave_map = cave_map
    end

    def finished?
      location == "end"
    end

    def next_steps
      next_valid_locations.map do |next_cave|
        CavePath.new(current_cave: next_cave, previous_path: path, cave_map: cave_map)
      end
    end

    def next_valid_locations
      cave_map[location].reject { |cave| small_cave?(cave) & invalid_small_cave?(cave) }
    end

    def invalid_small_cave?(cave)
      cave == "start" || (path.include?(cave) && have_visited_small_cave_twice)
    end

    def small_cave?(cave)
      /^[[:lower:]]+$/.match?(cave)
    end

    def have_visited_small_cave_twice
      path.detect {|cave| small_cave?(cave) && path.count(cave) > 1}
    end

    def to_s
      path.join(",")
    end
  end
end

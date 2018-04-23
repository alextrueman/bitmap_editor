class BitmapEditor
  class StepNotExists < StandardError; end
  class BoardNotExists < StandardError; end
  class FileNotExists < StandardError; end

  POSSIBLE_FIRST_STEPS = %w[I S].freeze

  def run(path)
    file = load_file(path)
    check_first_step(file.first[0])

    file.each do |line|
      select_action(line.split)
    end
  end

  private

  def check_first_step(step)
    return if POSSIBLE_FIRST_STEPS.include?(step)

    raise BoardNotExists, 'board should be created'
  end

  def select_action(line)
    step = line.shift

    case step
    when 'I' then create_board(*line)
    when 'L' then colour_pixel(*line)
    when 'V' then colour_vertical(*line)
    when 'H' then colour_horizontal(*line)
    when 'S' then show_board
    else
      raise StepNotExists, "unprocessable step: #{step}"
    end
  end

  def load_file(path)
    raise FileNotExists, 'please provide correct path' unless File.exists?(path.to_s)

    @_lines ||= File.open(path).read.split(/\R/)
  end

  def create_board(*args)
    y, x = map_to_i(*args)

    @board = Array.new(x) { Array.new(y, :O) }
  end

  def colour_pixel(*args, color)
    x, y = map_to_i(*args)

    @board[y-1][x-1] = color.to_sym
  end

  def colour_vertical(*args, color)
    x, y1, y2 = map_to_i(*args)

    (y1..y2).each do |y|
      @board[y-1][x-1] = color.to_sym
    end
  end

  def colour_horizontal(*args, color)
    x1, x2, y = map_to_i(*args)

    (x1..x2).each do |x|
      @board[y-1][x-1] = color.to_sym
    end
  end

  def map_to_i(*args)
    args.map(&:to_i)
  end

  def show_board
    print @board ? @board.map(&:join).join("\n") : "There is no image :("
  end
end

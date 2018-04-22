class BitmapEditor
  class StepNotExists < StandardError; end
  class BoardNotExists < StandardError; end
  class FileNotExists < StandardError; end

  POSSIBLE_FIRST_STEPS = %w[I S].freeze

  def run(path)
    file(path).each_with_index do |line, index|
      line = line.split

      if index.zero? && !POSSIBLE_FIRST_STEPS.include?(line.first)
        raise BoardNotExists, 'board should be created'
      else
        select_action(line)
      end
    end
  end

  private

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

  def file(path)
    raise FileNotExists, 'please provide correct path' unless File.exists?(path.to_s)

    File.open(path)
  end

  def create_board(y, x)
    x, y = x.to_i, y.to_i

    @board = Array.new(x) { Array.new(y, 'O') }
  end

  def colour_pixel(x, y, color)
    x, y = x.to_i, y.to_i

    @board[y-1][x-1] = color
  end

  def colour_vertical(x, y1, y2, color)
    x, y1, y2 = x.to_i, y1.to_i, y2.to_i

    (y1..y2).each do |y|
      @board[y-1][x-1] = color
    end
  end

  def colour_horizontal(x1, x2, y, color)
    x1, x2, y = x1.to_i, x2.to_i, y.to_i

    (x1..x2).each do |x|
      @board[y-1][x-1] = color
    end
  end

  def show_board
    print @board ? @board.map { |line| line.join }.join("\n") : "There is no image :("
  end
end

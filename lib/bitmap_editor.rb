require './services/validator'

class BitmapEditor
  class StepNotExists < StandardError; end
  class BoardNotExists < StandardError; end
  class FileNotExists < StandardError; end
  class ArgumentsNotValid < StandardError; end

  POSSIBLE_FIRST_STEPS = %w[I S].freeze

  def run(path)
    load_file(path).each_with_index do |line, index|
      check_first_step(line[0]) if index.zero?

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

    File.open(path)
  end

  def create_board(*args)
    @length, @height = prepare_arguments(*args, size: 2)

    @board = Array.new(@height) { Array.new(@length, :O) }
  end

  def colour_pixel(*args, color)
    x, y = prepare_arguments(*args, size: 2)
    validator.validate_one_pixel([x, y], height: @height, length: @length)

    @board[y-1][x-1] = color.to_sym
  end

  def colour_vertical(*args, color)
    x, y1, y2 = prepare_arguments(*args, size: 3)
    validator.validate_line(line: [y1, y2], position: x, line_target: @height, position_target: @length)

    (y1..y2).each do |y|
      @board[y-1][x-1] = color.to_sym
    end
  end

  def colour_horizontal(*args, color)
    x1, x2, y = prepare_arguments(*args, size: 3)
    validator.validate_line(line: [x1, x2], position: y, line_target: @length, position_target: @height)

    (x1..x2).each do |x|
      @board[y-1][x-1] = color.to_sym
    end
  end

  def prepare_arguments(*args, size:)
    args.map! { |e| Integer(e) }

    if args.size != size || args.any?(&:negative?)
      raise ArgumentsNotValid
    else
      args
    end
  end

  def show_board
    print @board ? @board.map(&:join).join("\n") : "There is no image :("
  end

  def validator
    Services::Validator.new
  end
end

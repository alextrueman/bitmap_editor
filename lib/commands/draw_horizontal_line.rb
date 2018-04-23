require_relative 'core'

class DrawHorizontalLine < Core
  def execute(*params, color)
    x1, x2, y = prepare_arguments(*params, size: 3)
    validator.validate_line(line: [x1, x2], position: y, line_target: @length, position_target: @height)

    (x1..x2).each do |x|
      @board[y-1][x-1] = color.to_sym
    end
  end
end

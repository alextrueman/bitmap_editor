require_relative 'core'

class DrawVericalLine < Core
  def execute(*params, color)
    x, y1, y2 = prepare_arguments(*params, size: 3)
    validator.validate_line(line: [y1, y2], position: x, line_target: @height, position_target: @length)

    (y1..y2).each do |y|
      @board[y-1][x-1] = color.to_sym
    end
  end
end

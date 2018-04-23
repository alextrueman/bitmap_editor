require_relative 'core'

class DrawPixel < Core
  def execute(*params, color)
    x, y = prepare_arguments(*params, size: 2)
    validator.validate_one_pixel([x, y], height: @height, length: @length)

    @board[y-1][x-1] = color.to_sym
  end
end

require_relative 'core'

class CreateBitmap < Core
  attr_accessor :board
  attr_reader :length, :height

  def initialize(*params)
    @length, @height = prepare_arguments(*params, size: 2)

    @board = create_board
  end

  def reinitialize
    @board = create_board
  end

  def create_board
    Array.new(@height) { Array.new(@length, :O) }
  end
end

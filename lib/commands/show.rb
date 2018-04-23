class Show < Core
  def initialize(bitmap)
    @board = bitmap&.board
  end

  def execute
    print @board ? @board.map(&:join).join("\n") : "There is no image :("
  end
end

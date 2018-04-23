class ClearBitmap < Core
  def initialize(bitmap)
    @bitmap = bitmap
  end

  def execute
    @bitmap.reinitialize
  end
end

class CoordinatesNotValid < StandardError; end

module Services
  class Validator
    def validate_line(line:, position:, line_target:, position_target:)
      return unless more_than?(line, line_target) || position > position_target || line.inject(:>)

      raise_error
    end

    def validate_one_pixel(coordinates, height:, length:)
      return unless coordinates.first > height || coordinates.last > length

      raise_error
    end

    def validate_board(length:, height:)
      return if [length, height].all? { |el| (1..255).cover? el }

      raise_error
    end

    private

    def raise_error
      raise CoordinatesNotValid, 'wrong coordinates'
    end

    def more_than?(args, target)
      args.any? { |el| el > target }
    end
  end
end

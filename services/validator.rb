class CoordinatesNotValid < StandardError; end

module Services
  class Validator
    def validate_line(line:, position:, line_target:, position_target:)
      return unless more_than?(line, line_target) || position > position_target || line.inject(:>)

      raise CoordinatesNotValid, 'wrong coordinates'
    end

    def validate_one_pixel(coordinates, height:, length:)
      return unless coordinates.first > height || coordinates.last > length

      raise CoordinatesNotValid, 'wrong coordinates'
    end

    private

    def more_than?(args, target)
      args.any? { |el| el > target }
    end
  end
end

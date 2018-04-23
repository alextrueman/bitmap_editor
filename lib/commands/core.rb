require './services/validator'

class Core
  class BoardNotExists < StandardError; end
  class ArgumentsNotValid < StandardError; end

  def initialize(bitmap)
    raise BoardNotExists, 'board should be created' unless bitmap

    @board = bitmap.board
    @length = bitmap.length
    @height = bitmap.height
  end

  def validator
    Services::Validator.new
  end

  def prepare_arguments(*args, size:)
    args.map! { |e| Integer(e) }

    if args.size != size || args.any?(&:negative?)
      raise ArgumentsNotValid
    else
      args
    end
  end
end

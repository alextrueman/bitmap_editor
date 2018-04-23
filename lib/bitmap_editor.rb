class BitmapEditor
  class FileNotExists < StandardError; end
  class StepNotExists < StandardError; end

  def run(path)
    load_file(path).each.with_index do |line, index|
      command, *params = line.split
      if index.zero? && command == 'I'
        create_board(*params)
      else
        execute_command(command, *params)
      end
    end
  end

  def execute_command(command, *params)
    find_command(command).new(@bitmap).public_send(*[:execute, *params].compact)
  end

  def find_command(command)
    Object.const_get(
      commands.fetch(command) { raise(StepNotExists, "unprocessable step") }
    )
  end

  def create_board(*params)
    @bitmap = CreateBitmap.new(*params)
  end

  def load_file(path)
    raise FileNotExists, 'please provide correct path' unless File.exists?(path.to_s)

    File.open(path)
  end

  def commands
    {
      'H' => 'DrawHorizontalLine',
      'S' => 'Show',
      'V' => 'DrawVericalLine',
      'L' => 'DrawPixel',
      'C' => 'ClearBitmap'
    }.freeze
  end
end

Dir[File.join('./lib/commands', '*')].each { |f| require(f) }

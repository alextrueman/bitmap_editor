require "./lib/bitmap_editor"

RSpec.describe BitmapEditor do
  describe "#run" do
    context "Colour pixel" do
      it "colour one pixel" do
        expect { subject.run('spec/fixtures/files/one_field_colour.txt') }
          .to output("OOO\nOFO\nOOO").to_stdout
      end
    end

    context "Colour vertical" do
      it "colour vertical line" do
        expect { subject.run('spec/fixtures/files/vertical_line.txt') }
          .to output("OOO\nOVO\nOVO").to_stdout
      end
    end

    context "Colour horizontal" do
      it "colour horizontal line" do
        expect { subject.run('spec/fixtures/files/horizontal_line.txt') }
          .to output("OOO\nOOO\nOHH").to_stdout
      end
    end

    context "Full bitmap" do
      it "colour all the bitmap" do
        expect { subject.run('spec/fixtures/files/full_bitmap.txt') }
          .to output("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO").to_stdout
      end
    end

    context "Empty bitmap" do
      it "return message 'There is no image :('" do
        expect { subject.run('spec/fixtures/files/empty_bitmap.txt') }
          .to output("There is no image :(").to_stdout
      end
    end

    context "Raise errors" do
      it "returns FileNotExists" do
        expect { subject.run('/some/wrong_way') }.to raise_error(/please provide correct path/)
      end

      it "returns StepNotExists" do
        expect { subject.run('spec/fixtures/files/step_not_exists.txt') }
          .to raise_error(/unprocessable step:/)
      end

      it "returns BoardNotExists" do
        expect { subject.run('spec/fixtures/files/board_not_exists.txt') }
          .to raise_error(/board should be created/)
      end

      it "returns CoordinatesNotValid" do
        expect { subject.run('spec/fixtures/files/wrong_horizontal_coordinates.txt') }
          .to raise_error(/wrong coordinates/)

        expect { subject.run('spec/fixtures/files/wrong_vertical_coordinates.txt') }
          .to raise_error(/wrong coordinates/)

        expect { subject.run('spec/fixtures/files/wrong_one_field_coordinates.txt') }
          .to raise_error(/wrong coordinates/)
      end
    end
  end
end

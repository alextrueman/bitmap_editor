require "./lib/bitmap_editor"
require "./services/validator"

RSpec.describe Services::Validator do
  describe "#validate_line" do
    context "when horizontal" do
      let(:action_with_good_params) {
        subject.validate_line(line: [3, 3], position: 2, line_target: 3, position_target: 3)
      }
      let(:action_with_bad_params) {
        subject.validate_line(line: [3, 3], position: 2, line_target: 2, position_target: 2)
      }

      it "shouldn't raise error" do
        expect { action_with_good_params }.not_to raise_error
      end

      it "should raise error" do
        expect { action_with_bad_params }.to raise_error(/wrong coordinates/)
      end
    end

    context "when vertical" do
      let(:action_with_good_params) {
        subject.validate_line(line: [2, 3], position: 2, line_target: 3, position_target: 3)
      }
      let(:action_with_bad_params) {
        subject.validate_line(line: [3, 3], position: 2, line_target: 2, position_target: 2)
      }

      it "shouldn't raise error" do
        expect { action_with_good_params }.not_to raise_error
      end

      it "should raise error" do
        expect { action_with_bad_params }.to raise_error(/wrong coordinates/)
      end
    end
  end

  describe "#validate_one_pixel" do
    let(:action_with_good_params) { subject.validate_one_pixel([2, 2], height: 3, length: 3) }
    let(:action_with_bad_params)  { subject.validate_one_pixel([3, 3], height: 2, length: 2) }

    it "shouldn't raise error" do
      expect { action_with_good_params }.not_to raise_error
    end

    it "should raise error" do
      expect { action_with_bad_params }.to raise_error(/wrong coordinates/)
    end
  end

  describe "#validate_board" do
    let(:action_with_good_params) { subject.validate_board(length: 3, height: 3) }
    let(:action_with_bad_params)  { subject.validate_board(length: 256, height: 2) }

    it "shouldn't raise error" do
      expect { action_with_good_params }.not_to raise_error
    end

    it "should raise error" do
      expect { action_with_bad_params }.to raise_error(/wrong coordinates/)
    end
  end
end

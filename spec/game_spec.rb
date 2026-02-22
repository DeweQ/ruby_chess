require_relative "../lib/game"

describe Game do
  describe "#toggle_current" do
    xit "change current player" do
    end
  end
  describe "#read" do
    xit "asks current player for input" do
    end
    context "when given correct move notation" do
      xit "return :type move" do
      end
    end
    context "when given correct command" do
      xit "return :type command" do
      end
    end
    context "when given unknown input" do
      xit "print wrong message" do
      end
      xit "loop behaviour" do
      end
    end
  end
  describe "#evaluate" do
    context "when given move" do
      xit "call make_move" do
      end
    end
    context "when given command" do
      xit "execute command" do
      end
    end
  end
  describe "#make_move" do
    context "when given valid move" do
      xit "call board to move piece" do
      end
      xit "toggle current player" do
      end
    end
  end
end

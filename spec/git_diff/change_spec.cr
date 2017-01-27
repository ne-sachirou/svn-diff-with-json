require "../spec_helper"

describe GitDiff::Change do
  describe "#line_number" do
    it "works" do
      patch = GitDiff::Change.new 42, [GitDiff::Line.new("+", "content")]
      patch.line_number.should eq 42
    end
  end

  describe "#lines" do
    it "works" do
      lines = [GitDiff::Line.new("+", "content")]
      patch = GitDiff::Change.new 42, lines
      patch.lines.should eq lines
    end
  end
end

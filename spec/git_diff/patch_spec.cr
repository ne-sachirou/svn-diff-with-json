require "../spec_helper"

describe GitDiff::Patch do
  describe "#file" do
    it "works" do
      patch = GitDiff::Patch.new "file.txt", [GitDiff::Change.new(42, [GitDiff::Line.new("+", "content")])]
      patch.file.should eq "file.txt"
    end
  end

  describe "#changes" do
    it "works" do
      changes = [GitDiff::Change.new(42, [GitDiff::Line.new("+", "content")])]
      patch = GitDiff::Patch.new "file.txt", changes
      patch.changes.should eq changes
    end
  end
end

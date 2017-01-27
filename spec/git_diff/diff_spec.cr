require "../spec_helper"

describe GitDiff::Diff do
  describe "#patches" do
    it "works" do
      patches = [GitDiff::Patch.new("file.txt", [GitDiff::Change.new(42, [GitDiff::Line.new("+", "content")])])]
      diff = GitDiff::Diff.new patches
      diff.patches.should eq patches
    end
  end
end

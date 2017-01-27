require "../spec_helper"

private macro it_is_expected_when_the_sign_is_sign(method, expected, sign)
  it "is {{expected}} when the sign is {{sign}}" do
    line = GitDiff::Line.new GitDiff::Line::{{sign}}, "content"
    line.{{method}}.should be_{{expected}}
  end
end

describe GitDiff::Line do
  describe "#sign" do
    it "works" do
      line = GitDiff::Line.new "+", "content"
      line.sign.should eq "+"
    end
  end

  describe "#content" do
    it "works" do
      line = GitDiff::Line.new "+", "content"
      line.content.should eq "content"
    end
  end

  describe "#not_modified?" do
    it_is_expected_when_the_sign_is_sign not_modified?, true, NOT_MODIFIED
    it_is_expected_when_the_sign_is_sign not_modified?, false, DELETED
    it_is_expected_when_the_sign_is_sign not_modified?, false, ADDED
  end

  describe "#deleted?" do
    it_is_expected_when_the_sign_is_sign deleted?, false, NOT_MODIFIED
    it_is_expected_when_the_sign_is_sign deleted?, true, DELETED
    it_is_expected_when_the_sign_is_sign deleted?, false, ADDED
  end

  describe "#added?" do
    it_is_expected_when_the_sign_is_sign added?, false, NOT_MODIFIED
    it_is_expected_when_the_sign_is_sign added?, false, DELETED
    it_is_expected_when_the_sign_is_sign added?, true, ADDED
  end
end

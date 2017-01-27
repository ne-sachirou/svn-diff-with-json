require "../spec_helper"

private def it_parses_correct(diff)
  it("patches.size") { diff.patches.size.should eq 4 }
  [
    {
      file:    "lib/saddler/reporter/github.rb",
      changes: [
        {
          line_number: 2,
          lines:       [
            {GitDiff::Line::NOT_MODIFIED, "require 'octokit'"},
            {GitDiff::Line::NOT_MODIFIED, "require 'git'"},
            {GitDiff::Line::NOT_MODIFIED, "require 'saddler/reporter/github/version'"},
            {GitDiff::Line::ADDED, "require 'saddler/reporter/github/support'"},
            {GitDiff::Line::NOT_MODIFIED, "require 'saddler/reporter/github/helper'"},
            {GitDiff::Line::NOT_MODIFIED, "require 'saddler/reporter/github/client'"},
            {GitDiff::Line::NOT_MODIFIED, "require 'saddler/reporter/github/comment'"},
          ],
        },
      ],
    },
    {
      file:    "lib/saddler/reporter/github/commit_comment.rb",
      changes: [
        {
          line_number: 2,
          lines:       [
            {GitDiff::Line::NOT_MODIFIED, "  module Reporter"},
            {GitDiff::Line::NOT_MODIFIED, "    module Github"},
            {GitDiff::Line::NOT_MODIFIED, "      class CommitComment"},
            {GitDiff::Line::ADDED, "        include Support"},
            {GitDiff::Line::NOT_MODIFIED, "        include Helper"},
            {GitDiff::Line::NOT_MODIFIED, ""},
            {GitDiff::Line::NOT_MODIFIED, "        # https://developer.github.com/v3/repos/comments/#create-a-commit-comment"},
          ],
        },
        {
          line_number: 12,
          lines:       [
            {GitDiff::Line::NOT_MODIFIED, "          data = parse(messages)"},
            {GitDiff::Line::NOT_MODIFIED, ""},
            {GitDiff::Line::NOT_MODIFIED, "          # build comment"},
            {GitDiff::Line::DELETED, "          body = build_body(data)"},
            {GitDiff::Line::ADDED, "          body = concat_body(data)"},
            {GitDiff::Line::NOT_MODIFIED, "          return if body.empty?"},
            {GitDiff::Line::NOT_MODIFIED, "          comment = Comment.new(sha1, body, nil, nil)"},
            {GitDiff::Line::NOT_MODIFIED, ""},
          ],
        },
        {
          line_number: 26,
          lines:       [
            {GitDiff::Line::NOT_MODIFIED, "          # create commit_comment"},
            {GitDiff::Line::NOT_MODIFIED, "          client.create_commit_comment(comment)"},
            {GitDiff::Line::NOT_MODIFIED, "        end"},
            {GitDiff::Line::DELETED, ""},
            {GitDiff::Line::DELETED, "        def build_body(data)"},
            {GitDiff::Line::DELETED, "          buffer = []"},
            {GitDiff::Line::DELETED, "          files = data['checkstyle']['file'] ||= []"},
            {GitDiff::Line::DELETED, "          files.each do |file|"},
            {GitDiff::Line::DELETED, "            errors = file['error'] ||= []"},
            {GitDiff::Line::DELETED, "            errors.each do |error|"},
            {GitDiff::Line::DELETED, "              severity = error['@severity'] && error['@severity'].upcase"},
            {GitDiff::Line::DELETED, "              message = error['@message']"},
            {GitDiff::Line::DELETED, "              buffer << [severity, message].compact.join(': ')"},
            {GitDiff::Line::DELETED, "            end"},
            {GitDiff::Line::DELETED, "          end"},
            {GitDiff::Line::DELETED, %q{          buffer.join("\n")}},
            {GitDiff::Line::DELETED, "        end"},
            {GitDiff::Line::NOT_MODIFIED, "      end"},
            {GitDiff::Line::NOT_MODIFIED, "    end"},
            {GitDiff::Line::NOT_MODIFIED, "  end"},
          ],
        },
      ],
    },
    {
      file:    "lib/saddler/reporter/github/helper.rb",
      changes: [
        {
          line_number: 2,
          lines:       [
            {GitDiff::Line::NOT_MODIFIED, "  module Reporter"},
            {GitDiff::Line::NOT_MODIFIED, "    module Github"},
            {GitDiff::Line::NOT_MODIFIED, "      module Helper"},
            {GitDiff::Line::DELETED, "        def initialize(output)"},
            {GitDiff::Line::DELETED, "          @output = output"},
            {GitDiff::Line::DELETED, "        end"},
            {GitDiff::Line::DELETED, ""},
            {GitDiff::Line::DELETED, "        def report(messages, _options)"},
            {GitDiff::Line::DELETED, "          @output.puts messages"},
            {GitDiff::Line::DELETED, "        end"},
            {GitDiff::Line::DELETED, ""},
            {GitDiff::Line::DELETED, %(        # {"checkstyle"=>)},
            {GitDiff::Line::DELETED, %(        #    {"file"=>)},
            {GitDiff::Line::DELETED, %(        #       [{"error"=>)},
            {GitDiff::Line::DELETED, %(        #           [{"@column"=>"4",)},
            {GitDiff::Line::DELETED, %(        #             "@line"=>"22",)},
            {GitDiff::Line::DELETED, %(        #             "@message"=>"Assignment Branch Condition size for report is too high. [34.34/15]",)},
            {GitDiff::Line::DELETED, %(        #             "@severity"=>"info",)},
            {GitDiff::Line::DELETED, %(        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/AbcSize"},)},
            {GitDiff::Line::DELETED, %(        #            {"@column"=>"4",)},
            {GitDiff::Line::DELETED, %(        #             "@line"=>"22",)},
            {GitDiff::Line::DELETED, %(        #             "@message"=>"Cyclomatic complexity for report is too high. [10/6]",)},
            {GitDiff::Line::DELETED, %(        #             "@severity"=>"info",)},
            {GitDiff::Line::DELETED, %(        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/CyclomaticComplexity"},)},
            {GitDiff::Line::DELETED, %(        #            {"@column"=>"6",)},
            {GitDiff::Line::DELETED, %(        #             "@line"=>"39",)},
            {GitDiff::Line::DELETED, %(        #             "@message"=>"Use space after control keywords.",)},
            {GitDiff::Line::DELETED, %(        #             "@severity"=>"info",)},
            {GitDiff::Line::DELETED, %(        #             "@source"=>"com.puppycrawl.tools.checkstyle.Style/SpaceAfterControlKeyword"}],)},
            {GitDiff::Line::DELETED, %(        #         "@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/cli.rb"},)},
            {GitDiff::Line::DELETED, %(        #        {"@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/reporter.rb"}]}})},
            {GitDiff::Line::DELETED, "        def parse(xml)"},
            {GitDiff::Line::DELETED, "          Nori"},
            {GitDiff::Line::DELETED, "            .new(parser: :rexml)"},
            {GitDiff::Line::DELETED, "            .parse(xml)"},
            {GitDiff::Line::ADDED, "        def concat_body(data)"},
            {GitDiff::Line::ADDED, "          buffer = []"},
            {GitDiff::Line::ADDED, "          files = data['checkstyle']['file'] ||= []"},
            {GitDiff::Line::ADDED, "          files.each do |file|"},
            {GitDiff::Line::ADDED, "            errors = file['error'] ||= []"},
            {GitDiff::Line::ADDED, "            errors.each do |error|"},
            {GitDiff::Line::ADDED, "              severity = error['@severity'] && error['@severity'].upcase"},
            {GitDiff::Line::ADDED, "              message = error['@message']"},
            {GitDiff::Line::ADDED, "              buffer << [severity, message].compact.join(': ')"},
            {GitDiff::Line::ADDED, "            end"},
            {GitDiff::Line::ADDED, "          end"},
            {GitDiff::Line::ADDED, %q{          buffer.join("\n")}},
            {GitDiff::Line::NOT_MODIFIED, "        end"},
            {GitDiff::Line::NOT_MODIFIED, "      end"},
            {GitDiff::Line::NOT_MODIFIED, "    end"},
            {GitDiff::Line::NOT_MODIFIED, "  end"},
            {GitDiff::Line::NOT_MODIFIED, "end"},
            {GitDiff::Line::ADDED, ""},
          ],
        },
      ],
    },
    {
      file:    "lib/saddler/reporter/github/support.rb",
      changes: [
        {
          line_number: 1,
          lines:       [
            {GitDiff::Line::ADDED, "module Saddler"},
            {GitDiff::Line::ADDED, "  module Reporter"},
            {GitDiff::Line::ADDED, "    module Github"},
            {GitDiff::Line::ADDED, "      module Support"},
            {GitDiff::Line::ADDED, "        def initialize(output)"},
            {GitDiff::Line::ADDED, "          @output = output"},
            {GitDiff::Line::ADDED, "        end"},
            {GitDiff::Line::ADDED, ""},
            {GitDiff::Line::ADDED, "        def report(messages, _options)"},
            {GitDiff::Line::ADDED, "          @output.puts messages"},
            {GitDiff::Line::ADDED, "        end"},
            {GitDiff::Line::ADDED, ""},
            {GitDiff::Line::ADDED, %(        # {"checkstyle"=>)},
            {GitDiff::Line::ADDED, %(        #    {"file"=>)},
            {GitDiff::Line::ADDED, %(        #       [{"error"=>)},
            {GitDiff::Line::ADDED, %(        #           [{"@column"=>"4",)},
            {GitDiff::Line::ADDED, %(        #             "@line"=>"22",)},
            {GitDiff::Line::ADDED, %(        #             "@message"=>"Assignment Branch Condition size for report is too high. [34.34/15]",)},
            {GitDiff::Line::ADDED, %(        #             "@severity"=>"info",)},
            {GitDiff::Line::ADDED, %(        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/AbcSize"},)},
            {GitDiff::Line::ADDED, %(        #            {"@column"=>"4",)},
            {GitDiff::Line::ADDED, %(        #             "@line"=>"22",)},
            {GitDiff::Line::ADDED, %(        #             "@message"=>"Cyclomatic complexity for report is too high. [10/6]",)},
            {GitDiff::Line::ADDED, %(        #             "@severity"=>"info",)},
            {GitDiff::Line::ADDED, %(        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/CyclomaticComplexity"},)},
            {GitDiff::Line::ADDED, %(        #            {"@column"=>"6",)},
            {GitDiff::Line::ADDED, %(        #             "@line"=>"39",)},
            {GitDiff::Line::ADDED, %(        #             "@message"=>"Use space after control keywords.",)},
            {GitDiff::Line::ADDED, %(        #             "@severity"=>"info",)},
            {GitDiff::Line::ADDED, %(        #             "@source"=>"com.puppycrawl.tools.checkstyle.Style/SpaceAfterControlKeyword"}],)},
            {GitDiff::Line::ADDED, %(        #         "@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/cli.rb"},)},
            {GitDiff::Line::ADDED, %(        #        {"@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/reporter.rb"}]}})},
            {GitDiff::Line::ADDED, "        def parse(xml)"},
            {GitDiff::Line::ADDED, "          Nori"},
            {GitDiff::Line::ADDED, "            .new(parser: :rexml)"},
            {GitDiff::Line::ADDED, "            .parse(xml)"},
            {GitDiff::Line::ADDED, "        end"},
            {GitDiff::Line::ADDED, "      end"},
            {GitDiff::Line::ADDED, "    end"},
            {GitDiff::Line::ADDED, "  end"},
            {GitDiff::Line::ADDED, "end"},
          ],
        },
      ],
    },
  ].each_with_index do |patch_param, patch_i|
    it("patches[#{patch_i}].file") { diff.patches[patch_i].file.should eq patch_param[:file] }
    it("patches[#{patch_i}].changes.size") { diff.patches[patch_i].changes.size.should eq patch_param[:changes].size }
    patch_param[:changes].each_with_index do |change_param, change_i|
      it("patches[#{patch_i}].changes[#{change_i}].lines.size") { diff.patches[patch_i].changes[change_i].lines.size.should eq change_param[:lines].size }
      change_param[:lines].each_with_index do |line_param, line_i|
        it("patches[#{patch_i}].changes[#{change_i}].lines[#{line_i}].sign") { diff.patches[patch_i].changes[change_i].lines[line_i].sign.should eq line_param[0] }
        it("patches[#{patch_i}].changes[#{change_i}].lines[#{line_i}].content") { diff.patches[patch_i].changes[change_i].lines[line_i].content.should eq line_param[1] }
      end
    end
  end
end

describe GitDiff::Parser do
  describe "#parse" do
    diff = GitDiff::Parser.new.parse File.read "spec/support/fixtures/d1bd180-c27866c.diff"
    # it_parses_correct diff
  end

  describe "#parse_stream" do
    diff = File.open("spec/support/fixtures/d1bd180-c27866c.diff") { |output| GitDiff::Parser.new.parse_stream output }
    it_parses_correct diff
  end
end

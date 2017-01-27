module SvnDiffWithJson
  class App
    def main(argv)
      diff = get_diff argv
      p diff
    end

    private def get_diff(svn_argv)
      IO.pipe do |reader, writer|
        spawn do
          Process.run "svn", %w(diff --git) + svn_argv, output: writer
          writer.close
        end
        GitDiff::Parser.new.parse_stream reader
      end
    end
  end
end

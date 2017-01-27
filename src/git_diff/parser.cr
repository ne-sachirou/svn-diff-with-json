module GitDiff
  class Parser
    def parse(str : String) : Diff
      parse_stream IO::Memory.new str
    end

    def parse_stream(stream : IO) : Diff
      patches = each_patch(stream).map do |patch_lines|
        changes = each_change(patch_lines.select { |line| line =~ %r{^(?!(?:---|\+\+\+))[-@ +\\]} }).map do |change_lines|
          line_number = 0
          lines = [] of Line
          change_lines.each do |change_line|
            case change_line
            when /^@@ .+?\+(?<line_number>\d+)/
              line_number = $~["line_number"].to_i
            when /^ (?<content>.*)/
              lines << Line.new " ", $~["content"]
            when /^\-(?<content>.*)/
              lines << Line.new "-", $~["content"]
            when /^\+(?<content>.*)/
              lines << Line.new "+", $~["content"]
            when /^\\(?<content>.*)/
              lines.pop.tap { |line| lines << Line.new line.sign, "#{line.content}\n#{$~["content"]}" }
            end
          end
          Change.new line_number, lines
        end
        file = patch_lines
          .find { |line| line =~ %r{^\+\+\+ b/} }
          .try { |line| line.tap { |line| break line.match(%r{^\+\+\+ b/(?<file>.+?)(?:\s\(revision (?<svn_revision>.+)\))?$}).try(&.["file"]) || "" } } || ""
        Patch.new file, changes.to_a
      end
      Diff.new patches.to_a
    end

    private def each_patch(stream)
      stream
        .each_line
        .skip_while { |line| !(line =~ /^diff/) }
        .chunk { |line| line =~ /^diff/ }
        .reject(&.[0])
        .map(&.[1])
    end

    private def each_patch(stream, &block)
      each_patch(stream).each { |patch| yield patch }
    end

    private def each_change(patch_lines)
      patch_lines
        .chunk { |line| line =~ /^@@ / }
        .map(&.[1])
        .each_slice(2)
        .map { |cons| cons[0].concat cons[1] }
    end

    private def each_change(patch_lines, &block)
      each_change(patch_lines).each { |change| yield change }
    end
  end
end

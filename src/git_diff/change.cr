module GitDiff
  class Change
    getter :line_number, :lines

    def initialize(@line_number : Int32, @lines : Array(Line))
    end
  end
end

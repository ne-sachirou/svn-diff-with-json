module GitDiff
  class Diff
    getter :patches

    def initialize(@patches : Array(Patch))
    end
  end
end

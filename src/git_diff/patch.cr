module GitDiff
  class Patch
    getter :file, :changes

    def initialize(@file : String, @changes : Array(Change))
    end
  end
end

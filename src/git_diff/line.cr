module GitDiff
  class Line
    NOT_MODIFIED = " "
    DELETED      = "-"
    ADDED        = "+"

    getter :sign, :content

    def initialize(@sign : String, @content : String)
    end

    def not_modified? : Bool
      @sign == NOT_MODIFIED
    end

    def deleted? : Bool
      @sign == DELETED
    end

    def added? : Bool
      @sign == ADDED
    end
  end
end

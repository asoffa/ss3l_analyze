
class SS3LAnalyze::RootUtils::Region
    property name        : String,
             cut         : String,
             displayName : String,
             cutFlow     : Hash(String, String)

    def initialize(@name, @cut, displayName?=nil)
        @displayName = displayName? ? displayName?.as(String) : @name
        @cutFlow = {} of String => String
    end

    def addCut(name : String, newCut : String)
        @cut = "(#{@cut}) && #{newCut}"
        @cutFlow[name] = @cut
    end

    def to_s(io : IO)
        io << @displayName
    end
end


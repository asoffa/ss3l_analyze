require "math"


struct SS3LAnalyze::RootUtils::Yield
    getter nWeighted : Float64?,
           statErr   : Float64?,
           isPercent : Bool

    def initialize(@nWeighted, @statErr, @isPercent=false)
        @statErr = 0.01 if @statErr && @statErr.as(Float64).abs < 0.01
    end

    def +(other : self)
        Yield.new @nWeighted + other.nWeighted, Math.sqrt @statErr**2 + other.statErr**2
    end

    def -(other : self)
        Yield.new @nWeighted + other.nWeighted, Math.sqrt @statErr**2 + other.statErr**2
    end

    def *(factor : Number)
        Yield.new @nWeighted * factor, @statErr * factor
    end

    def /(factor : Number)
        Yield.new @nWeighted / factor, @statErr / factor
    end

    def percentDiff(other : self)
        s  = @nWeighed
        ds = @statErr
        n  = other.nWeighted
        dn = other.statErr

        if n.abs < 1e-15
            return Yield.new nil, nil
        end

        integral = (s - n) / n * 100.0
        if s.abs < 1e-15
            return Yield.new integral, nil
        end

        statErr = s/n * 100.0 * Math.sqrt (ds/s)**2 + (dn/n)**2
        Yield.new integral, statErr, true
    end

    def latexEntry : String
        return "indeterminate" if ! @nWeighted

        statErrString = @statErr ? sprintf(".2f", @statErr) : "??"

        if @isPercent
            return "$< 0.01\\%$" if @nWeighted.as(Float64).abs < 0.01
            return sprintf "$%.2f\\, (\\pm %s)$", @nWeighted, statErrString
        else
            return "$< 0.01$" if @nWeighted.as(Float64).abs < 0.01
            return sprintf "$%.2f\\, (\\pm %s)$", @nWeighted, statErrString
        end
    end
end


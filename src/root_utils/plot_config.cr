require "../config"
require "./**"

class SS3LAnalyze::RootUtils::PlotConfig
    property region         : Region,
             variable       : String,
             name           : String,
             bkgColors      : Array(String),
             xLabel         : String?,
             yLabel         : String?,
             doLogY         : Bool,
             xBinWidth      : Float64?,
             xRange         : {Float64, Float64},
             yRange         : {Float64, Float64},
             useVarBinWidth : Bool,
             xBinEdges      : Array(Float64)?


    def initialize(@region, @variable, @treeVarName)
        @name           = "#{@region}_#{@variable}"
        @bkgColors      = Config::COLORS
        @doLogY         = false
        @xRange         = {0, 10}
        @yRange         = {0, 10}
        @useVarBinWidth = false
    end

    def nBinsX
        @useVarBinWidth ? @xBinEdges.size - 1 : ((@xRange[1] - @xRange[0])/@xBinWidth + 0.5).floor.to_i
    end

    def to_s(io : IO)
        io << "PlotConfig(" \
           << "region="      << @region      << ", " \
           << "variable="    << @variable    << ", " \
           << "name="        << @name        << ", " \
           << "xLabel="      << @xLabel      << ", " \
           << "yLabel="      << @yLabel      << ", " \
           << "logY?="       << @doLogY      << ", " \
           << "xBinWidth="   << @xBinWidth   << ", " \
           << "xRange="      << @xRange      << ", " \
           << "yRange="      << @yRange      << ", " \
           << "varBinWidth=" << @varBinWidth << ", " \
           << "xBinEdges="   << @xBinEdges   << ")"
    end
end


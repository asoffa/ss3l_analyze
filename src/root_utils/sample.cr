require "../config"
require "./root"
require "./region"
require "./yield"
require "./plot_config"


enum SampleType
    DATA
    MC_BKG
    FAKES
    QFLIP
    MC_SIGNAL
end


class Sample
    PB_TO_FB = 1000.0

    property name        : String,
             sampleType  : SampleType,
             dsidList    : Array(String),
             chain       : Root::TChain,
             weightVar   : String,
             scaleFactor : Float64,
             histo       : Root::TH1D?

    def initialize(@name, @sampleType, @dsidList, lumi=10.0)
        @weightVar   = "mcEventWeight"
        @scaleFactor = Config::LUMI_TO_SCALE_TO / lumi
        @chain       = Root::TChain.new "superNt", Config.rootFilePatterns(@dsidList, @sampleType)
    end

    def integralAndError(selection : String | Region) : {Float64, Float64}
        @chain.integralAndError selection
    end

    def getYield(selection : String | Region) : Yield
        intAndErr = @chain.integralAndError selection
        Yield.new intAndErr[0], intAndErr[1]
    end

    def updateHisto(cfg : PlotConfig)
        hName = "h_#{cfg.name}_#{@name}"

        h = if cfg.useVarBinWidth
                Root::TH1D.new hName, @name, cfg.xBins.size, cfg.xBins
            else
                Root::TH1D.new hName, @name, cfg.nBinsX, cfg.xMin, cfg.xMax
            end

        cmd = "#{cfg.variable} >> +#{hName}"
        sel = "(#{cfg.region.cut}) * #{@weightVar} * #{@scaleFactor}"
        @chain.draw cmd, sel

        nWeighted, statErr = h.integralAndError 0, -1

        puts "%s : %.4f +/- %.4f (chain entries: %d)" % @name, nWeighted, statErr, @chain.getEntries
    end

end


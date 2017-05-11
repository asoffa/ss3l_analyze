require "../../lib/root_link"

lib LibRoot
    alias CChar  = LibC::Char
    type  TFile  = Void
    type  TChain = Void
    type  TH1D   = Void

    fun setBatch(on? : Bool)

    # TFile
    fun newTFile(name : CChar*, option : CChar*)
    fun deleteTFile(file : Void*)

    # TChain
    fun newTChain(name : CChar*) : TChain*
    fun chainAdd(chain : TChain*, rootFilePatter : CChar*)
    fun deleteChain(chain : TChain*)
    fun chainDraw(chain : TChain*, expression : CChar*, selection : CChar*, option : CChar*) : Int64
    fun chainGetEntries(chain : TChain*) : Int64

    # TH1D
    fun newTH1D(name : CChar*, title : CChar*, nBinsX : Int64, xMin : Float64, xMax : Float64) : TH1D*
    fun histoIntegralAndError(histo : TH1D*, binX1 : Int64, binX2 : Int64, error : Float64*) : Float64
    fun deleteTH1D(histo : TH1D*)
end


module Root
    extend self

    def setBatch(on? : Bool)
        LibRoot.setBatch on?
    end

    class TFile
        @rootFile : LibRoot::TFile*

        def initialize(name : String, option : String)
            @rootFile = LibRoot.newTFile name.to_unsafe, option.to_unsafe
        end

        def finalize
            LibRoot.deleteTFile @rootFile
        end
    end

    class TChain
        @@nHist = 0
        @rootChain : LibRoot::TChain*

        def initialize(@name : String)
            @rootChain = LibRoot.newTChain @name.to_unsafe
        end

        def initialize(@name : String, rootFilePattern : String)
            @rootChain = LibRoot.newTChain @name.to_unsafe
            add rootFilePattern
        end

        def initialize(@name : String, rootFilePatterns : Array(String))
            @rootChain = LibRoot.newTChain @name.to_unsafe
            rootFilePatterns.each { |p| add p }
        end

        def add(rootFilePattern : String)
            LibRoot.chainAdd @rootChain, rootFilePattern.to_unsafe
        end

        def draw(expression : String, selection : String, option="goff") : Int64
            LibRoot.chainDraw @rootChain, expression.to_unsafe, selection.to_unsafe, option.to_unsafe
        end

        def getEntries
            LibRoot.chainGetEntries @rootChain
        end

        def integralAndError(selection : String, weightVar="eventWeight", scaleFactor=Config::LUMI_TO_SCALE_TO/10.0)
            @@nHist += 1
            hName = "h_#{@name}_#{@@nHist}"
            histo = TH1D.new hName, hName, 1, 0.0, 2.0
            draw "1 >> #{hName}", "(#{selection}) * #{weightVar} * #{scaleFactor}"
            histo.integralAndError 0, -1
        end

        def finalize
            LibRoot.deleteChain @rootChain
        end
    end

    class TH1D
        @rootHisto : LibRoot::TH1D*

        def initialize(name : String, title : String, nBinsX : Int, xMin : Float64, xMax : Float64)
            @rootHisto = LibRoot.newTH1D name.to_unsafe, title.to_unsafe, nBinsX.to_i64, xMin, xMax
        end

        def initialize(name : String, title : String, xBins : Array(Float64))
            @rootHisto = LibRoot.newTH1D_varBins name.to_unsafe, title.to_unsafe, xBins.size, xBins.to_unsafe
        end

        def integralAndError(binX1 : Int, binX2 : Int) : {Float64, Float64}
            integral = LibRoot.histoIntegralAndError @rootHisto, binX1.to_i64, binX2.to_i64, out error
            {integral, error}
        end

        def finalize
            LibRoot.deleteTH1D @rootHisto
        end
    end

end


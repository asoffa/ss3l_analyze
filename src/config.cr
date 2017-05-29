require "./root_utils/sample"

module SS3LAnalyze::Config
    private alias SampleType = RootUtils::SampleType

    LUMI_TO_SCALE_TO = 36.47  # in GeV


    # plotting

    PLOT_COLORS = [
        "#CC6600",
        "#ffff00",
        "#009900",
        "#00ffcc",
        "#0099ff",
        "#ff0099",
    ]


    # samples

    def self.rootFilePatterns(sampleType : SampleType, dsidSet : Set(String)? = nil) : Array(String)
        productionDir = ENV["CURRENT_PRODUCTION_DIR"]?
        raise "`CURRENT_PRODUCTION_DIR` environment variable not set" if ! productionDir

        subDir = case sampleType
                 when SampleType::DATA
                     "data"
                 when SampleType::MC_BKG
                     "mc_bkg"
                 when SampleType::FAKES
                     "fakes"
                 when SampleType::QFLIP
                     "qflip"
                 when SampleType::MC_SIGNAL
                     "mc_signal"
                 else
                     nil
                 end

        raise "invalid sample type: #{sampleType}" if ! subDir

        if dsidSet
            patternList = [] of String
            dsidSet.as(Set(String)).each do |dsid|
                patternList << "#{productionDir}/datasets_superNt/#{subDir}/out_#{dsid}/CENTRAL_#{dsid}.root"
            end

            return patternList
        end

        Dir["#{productionDir}/datasets_superNt/#{subDir}/out_*/CENTRAL_*.root*"]
    end
end


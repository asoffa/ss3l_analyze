require "./root_utils/sample"

module Config
    extend self

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

    def rootFilePatterns(dsidList : Array(String), sampleType : SampleType) : Array(String)
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

        patternList = [] of String
        dsidList.each do |dsid|
            patternList << "#{ENV["CURRENT_PRODUCTION_DIR"]}/datasets_superNt/#{subDir}/out_#{dsid}/CENTRAL_#{dsid}.root"
        end

        patternList
    end
end


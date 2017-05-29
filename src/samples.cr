require "./root_utils/sample"


module SS3LAnalyze::Samples
    private alias ST     = RootUtils::SampleType
    private alias Sample = RootUtils::Sample


    DIBOSON  = Sample.new "diboson", ST::MC_BKG, Set{"361069", "361070", "361071", "361072",
                                                     "361073", "363490", "363491"}
    TTV      = Sample.new "ttV"    , ST::MC_BKG, Set{"410155", "410218", "410219", "410220"}
    RARE     = Sample.new "rare"   , ST::MC_BKG, Set{"304014", "342284", "342285", "343365",
                                                     "343366", "343367", "361620", "361621",
                                                     "361622", "361623", "361624", "361625",
                                                     "361626", "361627", "410050", "410080",
                                                     "410081", "410215", "407321"}

    WW       = Sample.new "WW"       , ST::MC_BKG, Set{"361069", "361070"}
    WZ       = Sample.new "WZ"       , ST::MC_BKG, Set{"361071", "363491"}
    ZZ       = Sample.new "ZZ"       , ST::MC_BKG, Set{"361072", "361073", "363490"}
    TTW      = Sample.new "ttW"      , ST::MC_BKG, Set{"410155"}
    TTZ      = Sample.new "ttZ"      , ST::MC_BKG, Set{"410218", "410219", "410220"}
    TTH      = Sample.new "ttH"      , ST::MC_BKG, Set{"343365", "343366", "343367"}
    TRIBOSON = Sample.new "triboson" , ST::MC_BKG, Set{"361620", "361621", "361622", "361623",
                                                       "361624", "361625", "361626", "361627"}
    VH       = Sample.new "VH"       , ST::MC_BKG, Set{"342284", "342285"}
    MISC_TOP = Sample.new "misc. top", ST::MC_BKG, Set{"304014", "410050", "410080", "410081", "410215", "407321"}
    FOUR_TOP = Sample.new "4 top"    , ST::MC_BKG, Set{"410080"}

    FAKES    = Sample.new "fakes"    , ST::FAKES, nil, lumi=3.2
    QFLIP    = Sample.new "qflip"    , ST::QFLIP, nil, lumi=3.2


    TEST_BKG = {
        "diboson" => DIBOSON,
        "ttV"     => TTV,
        "FAKES"   => FAKES,
        "QFLIP"   => QFLIP,
    }

    BKG = {
        "diboson" => DIBOSON,
        "ttV"     => TTV,
        "ttH"     => TTH,
        "4 top"   => FOUR_TOP,
        "rare"    => RARE,
    }

    BKG_CATEGORIES = {
        "all prompt" => Sample.combine("all prompt", DIBOSON, TTV, RARE),
        "diboson"    => DIBOSON,
        "ttV"        => TTV,
        "rare"       => RARE,
        "fakes"      => FAKES,
        "qflip"      => QFLIP,
    }

    BKG_GROUPS = {
        "WW"        => WW,
        "WZ"        => WZ,
        "ZZ"        => ZZ,
        "ttW"       => TTW,
        "ttZ"       => TTZ,
        "ttH"       => TTH,
        "triboson"  => TRIBOSON,
        "VH"        => VH,
        "misc. top" => MISC_TOP,
        "fakes"     => FAKES,
        "qflip"     => QFLIP,
    }
end


require "./root_utils/sample"


module SS3LAnalyze::Samples
    private alias ST     = RootUtils::SampleType
    private alias Sample = RootUtils::Sample


    FOUR_TOP = Sample.new "4 top"    , ST::MC_BKG, Set{"410080"}

    # diboson
    WW       = Sample.new "WW"       , ST::MC_BKG, Set{"361069", "361070"}
    WZ       = Sample.new "WZ"       , ST::MC_BKG, Set{"361071", "363491"}
    ZZ       = Sample.new "ZZ"       , ST::MC_BKG, Set{"361072", "361073", "363490"}
    DIBOSON  = Sample.combine "diboson", WW, WZ, ZZ

    # ttV
    TTW      = Sample.new "ttW"      , ST::MC_BKG, Set{"410155"}
    TTZ      = Sample.new "ttZ"      , ST::MC_BKG, Set{"410218", "410219", "410220"}
    TTV      = Sample.combine "ttV", TTW, TTZ

    # rare
    VH       = Sample.new "VH"       , ST::MC_BKG, Set{"342284", "342285"}
    TTH      = Sample.new "ttH"      , ST::MC_BKG, Set{"343365", "343366", "343367"}
    MISC_TOP = Sample.new "misc. top", ST::MC_BKG, Set{"304014", "410050", "410080", "410081", "410215", "407321"}
    TRIBOSON = Sample.new "triboson" , ST::MC_BKG, Set{"361620", "361621", "361622", "361623", "361624", "361625",
                                                       "361626", "361627"}
    RARE     = Sample.combine "rare", VH, TTH, MISC_TOP, TRIBOSON

    # fakes and qflip
    FAKES    = Sample.new "fakes", ST::FAKES, nil, lumi=3.2
    QFLIP    = Sample.new "qflip", ST::QFLIP, nil, lumi=3.2


    # groupings:

    TEST_BKG       = [ DIBOSON, TTV, FAKES, QFLIP ]

    BKG            = [ DIBOSON, TTV, TTH, FOUR_TOP, RARE ]

    BKG_CATEGORIES = [ Sample.combine("all prompt", DIBOSON, TTV, RARE),
                       DIBOSON, TTV, RARE, FAKES, QFLIP ]

    BKG_GROUPS     = [ WW, WZ, ZZ, TTW, TTZ, TTH, TRIBOSON, VH, MISC_TOP, FAKES, QFLIP ]
end


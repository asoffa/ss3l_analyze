require "./root_utils/sample"

private alias ST = SampleType

module Samples
    FAKES = Sample.new("fakes"    , ST::MC_BKG, [] of String)
    QFLIP = Sample.new("qflip"    , ST::MC_BKG, [] of String)

    BKG_CATEGORIES = {
        "diboson" => Sample.new("diboson", ST::MC_BKG, ["361069", "361070", "361071", "361072",
                                                        "361073", "363490", "363491"]),
        "ttV"     => Sample.new("ttV"    , ST::MC_BKG, ["410155", "410218", "410219", "410220"]),
        "rare"    => Sample.new("rare"   , ST::MC_BKG, ["304014", "342284", "342285", "343365",
                                                        "343366", "343367", "361620", "361621",
                                                        "361622", "361623", "361624", "361625",
                                                        "361626", "361627", "410050", "410080",
                                                        "410081", "410215", "407321"]),
        "fakes"   => FAKES,
        "qflip"   => QFLIP,
    }


    BKG_GROUPS = {
        "WW"       => Sample.new("WW"       , ST::MC_BKG, ["361069", "361070"]),
        "WZ"       => Sample.new("WZ"       , ST::MC_BKG, ["361071", "363491"]),
        "ZZ"       => Sample.new("ZZ"       , ST::MC_BKG, ["361072", "361073", "363490"]),
        "ttW"      => Sample.new("ttW"      , ST::MC_BKG, ["410155"]),
        "ttZ"      => Sample.new("ttZ"      , ST::MC_BKG, ["410218", "410219", "410220"]),
        "ttH"      => Sample.new("ttH"      , ST::MC_BKG, ["343365", "343366", "343367"]),
        "triboson" => Sample.new("triboson" , ST::MC_BKG, ["361620", "361621", "361622", "361623", "361624", "361625", "361626", "361627"]),
        "VH"       => Sample.new("VH"       , ST::MC_BKG, ["342284", "342285"]),
        "top"      => Sample.new("misc. top", ST::MC_BKG, ["304014", "410050", "410080", "410081", "410215", "407321"]),
        "fakes"    => FAKES,
        "qflip"    => QFLIP,
    }

    ALL_SAMPLES = BKG_CATEGORIES.merge BKG_GROUPS
end


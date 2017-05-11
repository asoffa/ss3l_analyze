#require "option_parser"
require "../src/regions"
require "../src/samples"

# OptionParser not functional with ROOT software's PCRE version
regionName = ARGV[0]? ? ARGV[0] : "sr"
sampleName = ARGV[1]? ? ARGV[1] : "categories"

regionMap = case regionName
            when "all"
                Regions::ALL_REGIONS
            when "sr"
                Regions::SIGNAL_REGIONS
            when "vr"
                Regions::VALIDATION_REGIONS
            else
               puts "region not found: #{regionName}"
               exit 1
            end

sampleMap = case sampleName
            when "categories"
                Samples::BKG_CATEGORIES
            when "groups"
                Samples::BKG_GROUPS
            when "diboson"
                {"diboson" => Samples::BKG_CATEGORIES["diboson"]}
            when "ttV"
                {"ttV" => Samples::BKG_CATEGORIES["ttV"]}
            else
               puts "sample not found: #{sampleName}"
               exit 1
            end

regionMap.each do |reg, cut|
    puts "-"*50
    puts " Yields for #{reg}:"
    puts "-"*50
    sampleMap.each_value do |sample|
        y, err = sample.integralAndError cut
        printf "%12s : %.4f +/- %.4f\n", sample.name, y, err
    end
    puts
end


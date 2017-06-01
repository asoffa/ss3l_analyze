require "option_parser"
require "../src/regions"
require "../src/samples"

private alias Regions = SS3LAnalyze::Regions
private alias Samples = SS3LAnalyze::Samples

#-------------------------------------------------------------------------------

# default region, sample sets
regionName = "vr"
sampleName = "test"

OptionParser.parse! do |parser|
    parser.banner = "usage: print_yields [-r REGION] [-s SAMPLE]"
    parser.on("-r REGION", "--region REGION") { |r| regionName = r }
    parser.on("-s SAMPLE", "--sample SAMPLE") { |s| sampleName = s }
end

#-------------------------------------------------------------------------------

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

samples = case sampleName
          when "test"
              Samples::TEST_BKG
          when "categories"
              Samples::BKG_CATEGORIES
          when "groups"
              Samples::BKG_GROUPS
          when "diboson"
              [Samples::DIBOSON]
          when "ttV"
              [Samples::TTV]
          else
             puts "sample set not found: #{sampleName}"
             exit 1
          end

regionMap.each do |reg, cut|
    puts "-"*50
    puts " Yields for #{reg}:"
    puts "-"*50
    samples.each do |sample|
        y, err = sample.integralAndError cut
        printf "%12s : %.4f +/- %.4f\n", sample.name, y, err
    end
    puts
end


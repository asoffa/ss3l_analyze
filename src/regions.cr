
module Regions

    def self.andNotSR(cut : String) : String
        SIGNAL_REGIONS.each do |srName, srCut|
            if srName != "Rpc3LSS1b"
                cut = "(#{cut}) && !(#{srCut})"
            end
        end

        cut
    end


    SIGNAL_REGIONS = {
        "Rpc2L0bH"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20==0 && nJets_40>=6 && met>250 && meff>900",
        "Rpc2L0bS"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20==0 && nJets_25>=6 && met>150 &&              met/meff>0.25",
        "Rpc2L1bH"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=1 && nJets_25>=6 && met>250 &&              met/meff>0.2",
        "Rpc2L1bS"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=1 && nJets_25>=6 && met>150 && meff>600  && met/meff>0.25",
        "Rpc2L2bH"    => "nLeptons>-2 && lep_pt[1]>20 && nBjets_20>=2 && nJets_25>=6 &&            meff>1800 && met/meff>0.15",
        "Rpc2L2bS"    => "nLeptons>-2 && lep_pt[1]>20 && nBjets_20>=2 && nJets_25>=6 && met>200 && meff> 600 && met/meff>0.25",
        #"Rpc2L3bH"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=3 && nJets_25>=6 && met>250 && meff>1200",
        #"Rpc2L3bS"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=3 && nJets_25>=6 && met>150 &&              met/meff>0.2",
        "Rpc2Lsoft1b" => "nLeptons>=2 && lep_pt[0]>20 && lep_pt[0]<100 && lep_pt[1]>10 && nBjets_20>=1 && nJets_25>=6 && " +\
                                           "met>100 && met/meff>0.3",
        "Rpc2Lsoft2b" => "nLeptons>=2 && lep_pt[0]>20 && lep_pt[0]<100 && lep_pt[1]>10 && nBjets_20>=2 && nJets_25>=6 && " +\
                             "met>200 && meff>600 && met/meff>0.25",
        "Rpc3L0bH"    => "nLeptons>=3 && lep_pt[1]>20 && nBjets_20==0 && nJets_40>=4 && met>200 && meff>1600",
        "Rpc3L0bS"    => "nLeptons>=3 && lep_pt[1]>20 && nBjets_20==0 && nJets_40>=4 && met>200 && meff>600",
        "Rpc3L1bH"    => "nLeptons>=3 && lep_pt[1]>20 && nBjets_20>=1 && nJets_40>=4 && met>200 && meff>1600",
        "Rpc3L1bS"    => "nLeptons>=3 && lep_pt[1]>20 && nBjets_20>=1 && nJets_40>=4 && met>200 && meff>600",
        "Rpc3LSS1b"   => "nLeptons>=3 && lep_pt[1]>20 && elSS && nBjets_20>=1 && !hasSsDielectronZ_81_101",
        
        "Rpv2L0b"     => "nLeptons==2 && lep_pt[1]>20 && nBjets_20==0 && nJets_40>=6 && meff>1800 && !hasSsDielectronZ_81_101",
        "Rpv2L1bM"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=1 && nJets_50>=4 && meff>1800 && nNegLeptons>=2",
        "Rpv2L1bH"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=1 && nJets_50>=6 && meff>2200",
        "Rpv2L1bS"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=1 && nJets_50>=4 && meff>1200 && nNegLeptons>=2",
        "Rpv2L2bH"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=2 && nJets_40>=6 &&            meff>2000 &&                  !hasSsDielectronZ_81_101",
        "Rpv2L2bS"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=2 && nJets_50>=3 &&            meff>1200 &&                  nNegLeptons>=2",
        #"Rpv2L3bH"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=3 && nJets_40>=6 && meff>1800 && !hasSsDielectronZ_81_101",
        #"Rpv2L3bS"    => "nLeptons>=2 && lep_pt[1]>20 && nBjets_20>=3 && nJets_50>=3 && meff>1200 && nNegLeptons>=2",
    }

    VALIDATION_REGIONS = {
        "VRttW"  => andNotSR("nLeptons==2 && lep_pt[1] > 20 && nBaseLeptons==2 && nBjets_20>=1 && (nJets_40>=4 || (nJets_25>=3 && isMMChannel)) &&" +\
                             "met>45 && meff>550 && lep_pt[1]>40 && sumBjetPt/sumJetPt>0.25"),
        
        "VRttZ"  => andNotSR("nLeptons>=3 && lep_pt[1] > 20 && nBjets_20 >= 1 && nJets_35 >= 3 && meff > 450 && hasDileptonZ_81_101"),
        
        "VRWW"   => andNotSR("nLeptons==2 && lep_pt[1] > 20 && nBaseLeptons==2 && nBjets_20==0 && nJets_50>=2 && met>55 && meff>650 && lep_pt[1]>30 && " +\
                              "!hasDileptonZ_81_101 && lep_minDeltaRJet[0]>0.7 && lep_minDeltaRJet[1]>0.7 && lep12_deltaR>1.3"),
        
        "VRWZ4j" => andNotSR("nLeptons==3 && lep_pt[1]>20 && nBaseLeptons==3 && nBjets_20==0 && nJets_25>=4 && meff>450 && met/sumLepPt<0.7"),
        
        "VRWZ5j" => andNotSR("nLeptons==3 && lep_pt[1]>20 && nBaseLeptons==3 && nBjets_20==0 && nJets_25>=5 && meff>450 && met/sumLepPt<0.7"),
    }

    ALL_REGIONS = SIGNAL_REGIONS.merge VALIDATION_REGIONS
end


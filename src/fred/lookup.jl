using Base.Dates

const FredKeyTerms = [(:Nominal, :Real, :Spot), 
                      (:ConstantMaturity, (:Nominal, :Real), (:Daily, :Weekly, :Monthly)),
                      (:Forward, (:InstantRate, :TermPremium), (:Daily,)),
                      (:BreakevenInflation, (:InstantRate, :TermPremium), (:Daily, :Monthly)),
                      (:ZeroCoupon, (:InstantRate, :InstantYield), (:Daily)) ]

"""
    TreasuryRates 
       (:ConstantMaturity   ==> (:Nominal, :Real) => (:Daily, :Weekly, :Monthly) -> (Day(n), Month(n)),
       (:Forward            ==> ()), 
       (:BreakevenInflation ==> (:InstantRate, :TermPremium)  => (:Daily, :Monthly) : (Day(n), Month(n), Year(n)), 
       (:ZeroCoupon         ==> (:InstantRate, :InstantYield) => (:Daily))  
    IndexSeries    
        (:TradeWeighted  => (:Daily, :Weekly, :Monthly))
    SpotSeries    
        (:Gold => (:Morning[:USD,:EURO], :Afternoon[:USD.:EURO]) ),
        (:CrudeOil => (:WestTexas[:USD], :Brent[:USD]) ),
        (:NaturalGas => :USD) )
"""

const FredTreasuryRates = Dict([
  :ConstantMaturity => Dict([
    :Nominal => Dict([
              :Daily => Dict([
                       Year(30) => "DGS30", Year(20) => "DGS20",  Year(10) => "DGS10", Year(7) => "DGS7", 
                       Year(5) => "DGS5",  Year(3) => "DGS3", Year(2) => "DGS2",  Year(1) => "DGS1", 
                       Month(6) => "DGS6MO", Month(3) => "DGS3MO", Month(1) => "DGS1MO",  
                       Day(1) => "DGS1DA",
              ]), # :Daily
              :Weekly => Dict([
                       Year(30) => "WGS30", Year(20) => "WGS20",  Year(10) => "WGS10", Year(7) => "WGS7", 
                       Year(5) => "WGS5",  Year(3) => "WGS3", Year(2) => "WGS2",  Year(1) => "WGS1", 
                       Month(6) => "WGS6MO", Month(3) => "WGS3MO", Month(1) => "WGS1MO",  
                       Day(1) => "WGS1DA",
              ]), # :Weekly
              :Monthly => Dict([
                       Year(30) => "MGS30", Year(20) => "MGS20",  Year(10) => "MGS10", Year(7) => "MGS7", 
                       Year(5) => "MGS5",  Year(3) => "MGS3", Year(2) => "MGS2",  Year(1) => "WGS1", 
                       Month(6) => "MGS6MO", Month(3) => "MGS3MO", Month(1) => "MGS1MO",  
                       Day(1) => "MGS1DA",
              ]), # :Monthly
          ]),   # :Nominal       
   :Real =>  Dict([
              :Daily => Dict([ 
                       Year(30) => "DFII30", Year(20) => "DFII20",  Year(10) => "DFII10",
                       Year(7) => "DFII7",  Year(5) => "DFII5",
              ]), # :Daily
              :Weekly => Dict([
                      Year(30) => "WFII30", Year(20) => "WFII20",  Year(10) => "WFII10",
                      Year(7) => "WFII7",  Year(5) => "WFII5",
              ]), # :Weekly
              :Monthly => Dict([
                      Year(30) => "NFII30", Year(20) => "MFII20",  Year(10) => "MFII10",
                      Year(7) => "MFII7",  Year(5) => "MFII5",
              ]), # :Monthly
          ]),  # :Real
  ]),  # ConstantMaturity

   :BreakevenInflation => Dict([
             :Daily => Dict([
               Year(30) => "T30YIEM", Year(20) => "T20YIEM",  Year(10) => "T10YIEM",  Year(5) => "T5YIEM"
             ]), # :Daily
             :Monthly => Dict([
               Year(30) => "T30YIEM", Year(20) => "T20YIEM",  Year(10) => "T10YIEM", Year(5) => "T5YIEM" 
             ]), # :Monthly
           ]),   # :BreakevenInflationRate
        
   :Forward => Dict([
        :InstantRate => Dict([
               :Daily => Dict([
                      Year(10) => "THREEFF10", Year(9) => "THREEFF9",  Year(8) => "THREEFF8",  Year(7) => "THREEFF7",
                      Year(6) => "THREEFF6",  Year(5) => "THREEFF5",  Year(4) => "THREEFF4",  Year(3) => "THREEFF3",
                      Year(2) => "THREEFF2", Year(1) => "THREEFF1" 
                ]), # :Daily
             ]), # :InstantRate
       :TermPremium => Dict([
               :Daily => Dict([
                      Year(10) => "THREEFFTP10", Year(9) => "THREEFFTP9",  Year(8) => "THREEFFTP8",  Year(7) => "THREEFFTP7",
                      Year(6) => "THREEFFTP6",  Year(5) => "THREEFFTP5",  Year(4) => "THREEFFTP4",  Year(3) => "THREEFFTP3",
                      Year(2) => "THREEFFTP2", Year(1) => "THREEFFTP1" 
                ]), # :Daily
             ]), # :TermPremium
     ]),         # :Forward

  :ZeroCoupon => Dict([
        :InstantYield => Dict([
               :Daily => Dict([
                      Year(10) => "THREEFY10", Year(9) => "THREEFY9",  Year(8) => "THREEFY8",  Year(7) => "THREEFY7",
                      Year(6) => "THREEFY6",  Year(5) => "THREEFY5",  Year(4) => "THREEFY4",  Year(3) => "THREEFY3",
                      Year(2) => "THREEFY2", Year(1) => "THREEFY1" ]),
               ]), # :Daily
       :TermPremium => Dict([
               :Daily => Dict([
                      Year(10) => "THREEFYTP10", Year(9) => "THREEFYTP9",  Year(8) => "THREEFYTP8",  Year(7) => "THREEFYTP7",
                      Year(6) => "THREEFYTP6",  Year(5) => "THREEFYTP5",  Year(4) => "THREEFYTP4",  Year(3) => "THREEFYTP3",
                      Year(2) => "THREEFYTP2", Year(1) => "THREEFYTP1" ]),
               ]), # :Daily
     ]),           # :ZeroCoupon
     
  ]); # FredTreasuryRates

const FredIndexedSeries = Dict([
    
       :TradeWeightedUSD => Dict([
          :Daily => Dict([
            :Major => "DTWEXM", :Broad => "DTWEXB" 
          ]), # :Daily
          :Weekly => Dict([
            :Major => "TWEXM", :Broad => "TWEXMB" 
           ]), # :Weekly
          :Monthly => Dict([
             :Nominal => Dict([ :Major => "TWEXMMTH", :Broad => "TWEXBMTH" ]),
             :Real    => Dict([ :Major => "TWEXMPA",  :Broad => "TWEXBPA"  ]),
           ]), # :Monthly
       ]),    # :TradeWeightedUSD
  
  ]); # FredIndexedSeries

const FredSpotSeries = Dict([
    
  :Gold => Dict([
    :Daily => Dict([   
      :Morning => Dict([
                  :USD  => Dict([ Day(1) => "GOLDAMGBD228NLBM" ]),
                  :Euro => Dict([ Day(1) => "GOLDAMGBD230NLBM" ]), 
      ]), # :Morning
      :Afternoon => Dict([
                  :USD  => Dict([ Day(1) => "GOLDPMGBD228NLBM" ]),
                  :Euro => Dict([ Day(1) => "GOLDPMGBD230NLBM" ]),
      ]), # :Afternoon
    ]), # :Daily      
  ]), # :Gold

 :CrudeOil => Dict([
    :Daily => Dict([    
      :WestTexas => Dict([
        :USD  => Dict([ Day(1) => "DCOILWTICOM" ]), 
      ]),
      :Brent => Dict([
        :USD  => Dict([ Day(1) => "DCOILBRENTEU" ]), 
      ]),
    ]), # :Daily         
 ]), # :CrudeOil    

 :NaturalGas => Dict([
    :Daily([    
        :USD  => Dict([ Day(1) => "DHHNGSP" ]),
    ]), # :Daily        
 ]), # :NaturalGas

]); # FredSpotSeries

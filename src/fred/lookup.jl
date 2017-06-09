const FredKeyTerms = [(:Nominal, :Real, :Spot), 
                      (:ConstantMaturity, (:Nominal, :Real), (:Day, :Week, :Month)),
                      (:Forward, (:InstantRate, :TermPremium), (:Day,)),
                      (:BreakevenInflation, (:InstantRate, :TermPremium), (:Day, :Month)),
                      (:ZeroCoupon, (:InstantRate, :InstantYield), (:Day)) ]

"""
    TreasuryRates 
       (:ConstantMaturity   ==> (:Nominal, :Real) => (:Day, :Month, :Year) -> (Day(n), Month(n)),
       (:Forward            ==> ()), 
       (:BreakevenInflation ==> (:InstantRate, :TermPremium)  => (:Day, :Month) : (Day(n), Month(n), Year(n)), 
       (:ZeroCoupon         ==> (:InstantRate, :InstantYield) => (:Day))  
    IndexSeries    
        (:TradeWeighted  => (:Day, :Week, :Month))
    SpotSeries    
        (:Gold => (:Morning[:USD,:EURO], :Afternoon[:USD.:EURO]) ),
        (:CrudeOil => (:WestTexas[:USD], :Brent[:USD]) ),
        (:NaturalGas => :USD) )
"""
const FredTreasuryRates = Dict([
  :ConstantMaturity => Dict([
    :Nominal => Dict([
              :Day => Dict([
                       Year(30) => "DGS30", Year(20) => "DGS20",  Year(10) => "DGS10", Year(7) => "DGS7", 
                       Year(5) => "DGS5",  Year(3) => "DGS3", Year(2) => "DGS2",  Year(1) => "DGS1", 
                       Month(6) => "DGS6MO", Month(3) => "DGS3MO", Month(1) => "DGS1MO",  
                       Day(1) => "DGS1DA",
                     ]),
              :Week => Dict([
                       Year(30) => "WGS30", Year(20) => "WGS20",  Year(10) => "WGS10", Year(7) => "WGS7", 
                       Year(5) => "WGS5",  Year(3) => "WGS3", Year(2) => "WGS2",  Year(1) => "WGS1", 
                       Month(6) => "WGS6MO", Month(3) => "WGS3MO", Month(1) => "WGS1MO",  
                       Day(1) => "WGS1DA",
                     ]),
              :Month => Dict([
                       Year(30) => "MGS30", Year(20) => "MGS20",  Year(10) => "MGS10", Year(7) => "MGS7", 
                       Year(5) => "MGS5",  Year(3) => "MGS3", Year(2) => "MGS2",  Year(1) => "WGS1", 
                       Month(6) => "MGS6MO", Month(3) => "MGS3MO", Month(1) => "MGS1MO",  
                       Day(1) => "MGS1DA",
                    ]),
          ]),   # :Nominal       
   :Real =>  Dict([
              :Day => Dict([ 
                       Year(30) => "DFII30", Year(20) => "DFII20",  Year(10) => "DFII10",
                       Year(7) => "DFII7",  Year(5) => "DFII5",
                     ]),
              :Week => Dict([
                      Year(30) => "WFII30", Year(20) => "WFII20",  Year(10) => "WFII10",
                      Year(7) => "WFII7",  Year(5) => "WFII5",
                    ]),
              :Month => Dict([
                      Year(30) => "NFII30", Year(20) => "MFII20",  Year(10) => "MFII10",
                      Year(7) => "MFII7",  Year(5) => "MFII5",
                    ]),
          ]),  # :Real
  ]),  # ConstantMaturity

   :BreakevenInflation => Dict([
             :Day => Dict([
               Year(30) => "T30YIEM", Year(20) => "T20YIEM",  Year(10) => "T10YIEM",  Year(5) => "T5YIEM" ]),
             :Month => Dict([
               Year(30) => "T30YIEM", Year(20) => "T20YIEM",  Year(10) => "T10YIEM", Year(5) => "T5YIEM" ]),
           ]),   # :BreakevenInflationRate
        
   :Forward => Dict([
        :InstantRate => Dict([
               :Day => Dict([
                      Year(10) => "THREEFF10", Year(9) => "THREEFF9",  Year(8) => "THREEFF8",  Year(7) => "THREEFF7",
                      Year(6) => "THREEFF6",  Year(5) => "THREEFF5",  Year(4) => "THREEFF4",  Year(3) => "THREEFF3",
                      Year(2) => "THREEFF2", Year(1) => "THREEFF1" ]),
             ]),
       :TermPremium => Dict([
               :Day => Dict([
                      Year(10) => "THREEFFTP10", Year(9) => "THREEFFTP9",  Year(8) => "THREEFFTP8",  Year(7) => "THREEFFTP7",
                      Year(6) => "THREEFFTP6",  Year(5) => "THREEFFTP5",  Year(4) => "THREEFFTP4",  Year(3) => "THREEFFTP3",
                      Year(2) => "THREEFFTP2", Year(1) => "THREEFFTP1" ]),
             ]),
     ]),         # :Forward

  :ZeroCoupon => Dict([
        :InstantYield => Dict([
               :Day => Dict([
                      Year(10) => "THREEFY10", Year(9) => "THREEFY9",  Year(8) => "THREEFY8",  Year(7) => "THREEFY7",
                      Year(6) => "THREEFY6",  Year(5) => "THREEFY5",  Year(4) => "THREEFY4",  Year(3) => "THREEFY3",
                      Year(2) => "THREEFY2", Year(1) => "THREEFY1" ]),
             ]),
       :TermPremium => Dict([
               :Day => Dict([
                      Year(10) => "THREEFYTP10", Year(9) => "THREEFYTP9",  Year(8) => "THREEFYTP8",  Year(7) => "THREEFYTP7",
                      Year(6) => "THREEFYTP6",  Year(5) => "THREEFYTP5",  Year(4) => "THREEFYTP4",  Year(3) => "THREEFYTP3",
                      Year(2) => "THREEFYTP2", Year(1) => "THREEFYTP1" ]),
             ]),+
     ]),           # :ZeroCoupon
     
  ]); # FredTreasuryRates

const FredIndexedSeries = Dict([
    
       :TradeWeightedUSD => Dict([
          :Day => Dict([
            :Major => "DTWEXM", :Broad => "DTWEXB" 
          ]), # :Day
          :Week => Dict([
            :Major => "TWEXM", :Broad => "TWEXMB" 
           ]), # :Week
          :Month => Dict([
             :Nominal => Dict([ :Major => "TWEXMMTH", :Broad => "TWEXBMTH" ]),
             :Real    => Dict([ :Major => "TWEXMPA",  :Broad => "TWEXBPA"  ]),
             ]), # :Month
           ]),    # :TradeWeightedUSD
  
  ]); # FredIndexedSeries

const FredSpotSeries = Dict([
    
  :Gold => Dict([ 
      :Morning => Dict([
                  :USD  => Dict([ Day(1) => "GOLDAMGBD228NLBM" ]),
                  :Euro => Dict([ Day(1) => "GOLDAMGBD230NLBM" ]), 
        ]), # :Morning
      :Afternoon => Dict([
                  :USD  => Dict([ Day(1) => "GOLDPMGBD228NLBM" ]),
                  :Euro => Dict([ Day(1) => "GOLDPMGBD230NLBM" ]),
        ]), # :Afternoon
   ]), # :Gold

 :CrudeOil => Dict([ 
      :WestTexas => Dict([
        :USD  => Dict([ Day(1) => "DCOILWTICOM" ]), ]),
      :Brent => Dict([
        :USD  => Dict([ Day(1) => "DCOILBRENTEU" ]), ]),
   ]), # :CrudeOil    

 :NaturalGas => Dict([
        :USD  => Dict([ Day(1) => "DHHNGSP" ]),
   ]), # :NaturalGas

]); # FredSpotSeries

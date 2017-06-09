module GetFinancialSeries

export fred, google, quandl #, yahoo

include("fred/lookup.jl")
include("fred/request.jl")
include("fred/update.jl")

include("google/lookup.jl")
include("google/request.jl")
include("google/update.jl")

include("quandl/lookup.jl")
include("quandl/request.jl")
include("quandl/update.jl")

#=
include("yahoo/lookup.jl")
include("yahoo/request.jl")
include("yahoo/update.jl")
=#

end # module

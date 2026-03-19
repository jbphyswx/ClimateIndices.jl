module Indices

using ..Data: LatLonGridData
using ..Selectors: LatLonBoxSelector
using ..Engines: AreaMean
using Dates: Dates

include("index_types.jl")

"""
    calculate(index::AbstractIndex, data::LatLonGridData)

Calculate the specified climate index for the given data and return a ClimateIndex object.
"""
function calculate(index::AbstractIndex, data::LatLonGridData)
    # Perform calculation via functor call
    index_result = index(data)
    
    # Wrap in ClimateIndex with metadata
    return ClimateIndex(index_result, (
        method="calculate($(typeof(index)), ...)", 
        timestamp=Dates.now()
    ))
end

end # module Indices

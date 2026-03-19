module ClimateIndices

using Dates: Dates
using Statistics: Statistics
using NaNStatistics: NaNStatistics

# --- Submodules ---

include("Data/Data.jl")
using .Data: Data

include("Selectors/Selectors.jl")
using .Selectors: Selectors

include("Engines/Engines.jl")
using .Engines: Engines

include("Indices/Indices.jl")
using .Indices: Indices

include("Backends/Backends.jl")
using .Backends: Backends

include("Reducers/Reducers.jl")
using .Reducers: Reducers

# --- Top-level Exports ---

using .Indices: ClimateIndex, ClimateIndexMeta, ENSO, ENSO34, calculate
using .Engines: AreaMean, RegionDifference
using .Data: LatLonGridData, Lat, Lon, Time, DateTime, Pressure, Altitude
using .Selectors: LatLonBoxSelector

export ClimateIndex, ClimateIndexMeta
export AreaMean, RegionDifference
export ENSO, ENSO34, calculate
export LatLonGridData, LatLonBoxSelector
export Lat, Lon, Time, DateTime, Pressure, Altitude

# Base.show for ClimateIndex
Base.show(io::IO, ci::ClimateIndex) = print(io, "ClimateIndex($(ci.index))")

end

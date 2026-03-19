module Engines

using ..Data: Lat, Lon, LatLonGridData

abstract type AbstractEngine end

struct AreaMean <: AbstractEngine
    lat_range::Tuple{Float64, Float64}
    lon_range::Tuple{Float64, Float64}
end

struct RegionDifference <: AbstractEngine
    e1::AbstractEngine
    e2::AbstractEngine
end

"""
    (::AreaMean)(data::LatLonGridData)

Calculate the area-weighted mean for LatLonGridData using its dimension names.
"""
function (e::AreaMean)(grid_data::LatLonGridData)
    # Find dimension positions
    lat_dim_idx = findfirst(d -> d isa Lat, grid_data.dimnames)
    lon_dim_idx = findfirst(d -> d isa Lon, grid_data.dimnames)
    
    isnothing(lat_dim_idx) && error("Latitude dimension not found in data")
    isnothing(lon_dim_idx) && error("Longitude dimension not found in data")

    # Weight by cos(lat)
    lats = grid_data.lat
    weights = cosd.(lats) # cosine and other weighting needs to be abstracted out!
    
    # Reshape weights for broadcasting
    # Create a shape with 1s everywhere except at lat_dim_idx
    weight_shape = ones(Int, length(grid_data.dimnames))
    weight_shape[lat_dim_idx] = length(lats)
    weights_reshaped = reshape(weights, Tuple(weight_shape))
    
    # Weighted average over Lat and Lon dimensions
    weighted_data = grid_data.data .* weights_reshaped
    
    # Reducing over lat and lon
    numerator = sum(weighted_data, dims=(lat_dim_idx, lon_dim_idx))
    
    # Denominator is sum(weights) * size along lon dimension
    lon_size = size(grid_data.data, lon_dim_idx)
    denominator = sum(weights) * lon_size
    
    return numerator ./ denominator
end

end # module Engines

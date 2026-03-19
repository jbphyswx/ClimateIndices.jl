"""


"""

abstract type AbstractSelector end

abstract type RegionSelector <: AbstractSelector end
abstract type PointSelector <: AbstractSelector end

struct ExactPointSelector{FT} <: PointSelector
    lat::FT
    lon::FT
end

struct NearestPointSelector{FT} <: PointSelector
    lat::FT
    lon::FT
end

struct LatLonBoxSelector{FT} <: RegionSelector
    lat_range::Tuple{FT, FT}
    lon_range::Tuple{FT, FT}
end


function (s::LatLonBoxSelector)(data::LatLonGridData)
    # Find dimension positions
    lat_dim_idx = findfirst(d -> d isa Lat, data.dimnames)
    lon_dim_idx = findfirst(d -> d isa Lon, data.dimnames)
    
    isnothing(lat_dim_idx) && error("Latitude dimension not found in data")
    isnothing(lon_dim_idx) && error("Longitude dimension not found in data")

    # Find indices for ranges
    lat_indices = findall(l -> s.lat_range[1] <= l <= s.lat_range[2], data.lat)
    lon_indices = findall(l -> s.lon_range[1] <= l <= s.lon_range[2], data.lon)
    
    # Build indexing tuple efficiently using ntuple to avoid vector allocation and Any
    indices = ntuple(length(data.dimnames)) do i
        if i == lat_dim_idx
            return lat_indices
        elseif i == lon_dim_idx
            return lon_indices
        else
            return Colon()
        end
    end
    
    # Extract sub-data using view to avoid copying large arrays
    sub_data = view(data.data, indices...)
    
    # Return new grid data with views for lat/lon as well
    return LatLonGridData(
        sub_data, view(data.lat, lat_indices), view(data.lon, lon_indices), 
        data.time, data.z, data.dimnames
    )
end

function select_data(data::LatLonGridData, selector::AbstractSelector)
    return selector(data)
end


"""
Given a tuple of indices (in order), index the data
"""
function index_data(data, indices)
    return view(data, indices...)
end
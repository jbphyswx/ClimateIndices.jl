"""
We should have pure items that are just the index values, and then the ClimateIndex object can hold date, metadata, etc

"""

abstract type AbstractIndex end
abstract type AbstractClimateIndex <: AbstractIndex end

"""
    ClimateIndex{IT, MT}

A container for climate index values and associated metadata.
"""
struct ClimateIndex{IT, MT}
    index::IT
    metadata::MT
end


abstract type ClimateIndexMetadata end

struct ClimateIndexMeta{TT}
    time::TT # clima datetime objects
    # region::RT # ...
end

abstract type AbstractENSO <: AbstractClimateIndex end

# Store ENSO value(s)
struct ENS0{T} <: AbstractENSO
    value::T
end

struct ENSO34{T} <: AbstractENSO
    value::T
end
# Default constructor for calculation spec
ENSO34() = ENSO34(nothing)

function (::ENSO34)(data::LatLonGridData)
    # Coerce to FT of the data if possible for type stability
    FT = eltype(data.data)
    # NINO3.4: 5°S-5°N, 170°W-120°W
    selector = LatLonBoxSelector((FT(-5.0), FT(5.0)), (FT(-170.0), FT(-120.0))) # should probably coerce to FT of the data if possible
    region_data = selector(data)
    
    engine = AreaMean()
    val = engine(region_data)
    
    return ENSO34(val)
end



abstract type AbstractSOI <: AbstractClimateIndex end

struct SOI{T} <: AbstractSOI
    value::T
end

abstract type AbstractMJO <: AbstractClimateIndex end

abstract type AbstractPDO <: AbstractClimateIndex end

abstract type AbstractAMO <: AbstractClimateIndex end

abstract type AbstractNAO <: AbstractClimateIndex end

abstract type AbstractAAO <: AbstractClimateIndex end

abstract type AbstractIOD <: AbstractClimateIndex end

abstract type AbstractPNA <: AbstractClimateIndex end

abstract type AbstractAO <: AbstractClimateIndex end

abstract type AbstractTAO <: AbstractClimateIndex end

abstract type AbstractIPO <: AbstractClimateIndex end

abstract type AbstractQBO <: AbstractClimateIndex end

abstract type AbstractSunspot <: AbstractClimateIndex end

abstract type AbstractVolcano <: AbstractClimateIndex end

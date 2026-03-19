"""
    Here we define types of data

    Note we will have a dichotomy between unlabeled data (pure arrays), and labeled data (e.g. DimensionalData.jl)

    We will not provide the methods for labeled data, in each extension, we will provide the methods for that specific labeled data type

    
"""

abstract type AbstractData end


abstract type GridData <: AbstractData end
abstract type PointData <: AbstractData end

abstract type RegularGridData <: GridData end
abstract type IrregularGridData <: GridData end


# ============================================================================
# Dimensions
# ============================================================================
abstract type AbstractDimension end

struct Lat <: AbstractDimension end
struct Lon <: AbstractDimension end

abstract type AbstractTimeDimension <: AbstractDimension end
struct Time <: AbstractDimension end
struct DateTime <: AbstractDimension end
# CFtime etc

abstract type AbstractVerticalDimension <: AbstractDimension end

struct Pressure <: AbstractVerticalDimension end
const P = Pressure

struct GeopotentialHeight <: AbstractVerticalDimension end
const H = GeopotentialHeight
const Φ = GeopotentialHeight

struct Altitude <: AbstractVerticalDimension end
const Z = Altitude




struct LatLonGridData{DTYPE, LATTYPE, LONTYPE, TTYPETYPE, ZTYPE, N} <: GridData
    data::DTYPE 
    lat::LATTYPE
    lon::LONTYPE
    time::TTYPETYPE
    z::ZTYPE
    dimnames::NTuple{N, AbstractDimension}
end

# Outer constructor to simplify creation
function LatLonGridData(data, lat, lon, time, z, dimnames)
    return LatLonGridData{
        typeof(data), typeof(lat), typeof(lon), typeof(time), typeof(z), length(dimnames)
    }(data, lat, lon, time, z, dimnames)
end

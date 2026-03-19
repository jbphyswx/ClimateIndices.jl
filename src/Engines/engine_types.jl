abstract type AbstractEngine end

struct AreaMean <: AbstractEngine end

struct RegionDifference <: AbstractEngine
    e1::AbstractEngine
    e2::AbstractEngine
end
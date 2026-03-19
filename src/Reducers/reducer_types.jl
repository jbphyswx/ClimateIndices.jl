abstract type AbstractReducer end

struct AreaMeanReducer <: AbstractReducer end

function (::AreaMeanReducer)(data::LatLonGridData)
    error("not implemented yet")
end


# Time means (hourly, daily, monthly, yearly)


# Rolling reductions (are there packages to help with these?)


# Time mean differences (e.g. now - historical mean) -- can these be formed by composition in a type stable way?

struct TimeMeanDifferenceReducer{TPL, TPE} <: AbstractReducer
    time_period_later::TPL
    time_period_earlier::TPE
end

function (r::TimeMeanDifferenceReducer)(data::LatLonGridData)
    # Sketch for composition
    # return (select(data, r.time_period_later) |> mean) - (select(data, r.time_period_earlier) |> mean)
    error("not implemented yet")
end
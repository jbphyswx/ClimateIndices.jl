using ClimateIndices: ClimateIndices as CI
using Test: Test
using Dates: Dates

Test.@testset "ClimateIndices.jl" begin
    # Create dummy LatLonGridData with non-standard dimension order: (Time, Lat, Lon, Altitude)
    lats = Base.collect(Base.range(-90, 90, length=180))
    lons = Base.collect(Base.range(-180, 180, length=360))
    times = [Dates.DateTime(2020, 1, 1)]
    z = [0.0]
    
    # Random data (Time, Lat, Lon, Altitude)
    data_array = Base.rand(1, 180, 360, 1)
    
    dimnames = (CI.Time(), CI.Lat(), CI.Lon(), CI.Altitude())
    
    grid_data = CI.LatLonGridData(data_array, lats, lons, times, z, dimnames)
    
    # Try calculating ENSO34 using the new generic calculate API
    # 1. Create the index specification (functor object)
    nino34_spec = CI.ENSO34()
    
    # 2. Call calculate
    res = CI.calculate(nino34_spec, grid_data)
    
    Test.@test res isa CI.ClimateIndex
    Test.@test res.index isa CI.ENSO34
    Test.@test !Base.isempty(res.metadata)

    res2 = nino34_spec(grid_data)
    Test.@test res2 isa CI.ENSO34 

    
    
    Base.println("Successfully calculated ENSO34 using generic calculate API!")
    Base.println("Result: ", res)
end

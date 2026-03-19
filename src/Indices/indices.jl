"""
    ENSO(SST, lat, lon, time; reference_period=..., windowing=...)

A sample implementation of the ENSO index.
"""
function ENSO(SST, lat, lon, time; reference_period=nothing, windowing=nothing)
    # Define NINO3.4 region
    nino34 = AreaMean((-5.0, 5.0), (-170.0, -120.0))
    
    # Calculate index using the engine
    val = nino34(SST, lat, lon, time)
    
    # Handle reference period and windowing
    # ...
    
    return ClimateIndex(val, (region="NINO3.4", name="ENSO"))
end

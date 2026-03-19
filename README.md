This is meant to be a package for calculating climate indices.


Unlike some other packages, this package is not meant to provide indices. Think ENSO, SOI, MJO, PDO, AMO, etc (including standard reference periods with the option of choosing custom reference periods if necessary, as well as rolling and other calcuations). Also like global things like global mean temperature etc that other packages might provide.
Since those indices are also somewhat arbitrary, it also aims to allow the user to define their own indices.

Indicies engines include area means, point/region differences, etc... These operations should be composable... So I should be able to take e.g. the difference between averages over two areas as my custom index.

We can also blend variables etc.... though only common ones are provided by default

Backends for right now are only ERA5 (in an extension), but we want to provide the capability to bring any backend, so long as it conforms to a standard where the data is provided as an NDArray or 1D Table with lat, lon, and DateTime (z or p or height if needed)

Returns ClimateIndex{...} objects, which can contain any object type for the index, and some tbd metadata 

The main package will only have the core methods, anything else will live in extensions.
The core methods will accept not the full labeled arrays, but only the data critically necessary for the calculation... so you could imagine ENSO could be:
    ENSO(SST, lat, lon, time, reference_period=..., windowing=...) 

(note this is just an example, i havent even started making the packge yet so i have no idea if this is a good API yet)


In extensions, we would seek to handle custom grid and stuff like that instead of assuming we can always just do lat-lon grids

Possible references:
    - [ClimateTools.jl](https://github.com/JuliaClimate/ClimateTools.jl)
    - [ClimateBase.jl](https://github.com/JuliaClimate/ClimateBase.jl)
    - [CDSAPI.jl](https://github.com/JuliaClimate/STAC.jl)
    - []https://github.com/juliaocean/Climatology.jl    
    - []https://github.com/gaelforget/ClimateModels.jl?
    - []https://github.com/google-research/arco-era5


To deal with the wide array of possible patterns, maybe it would be helpful if we defined formal interfaces, and rather than having custom methods for every time, cftim,e, data type, etc, we added methods to implement those interfaces? idk.. might be too hard though...

Also we can probably certainly rely on other packages in some places in lieu of implementing everything ourselves.. once we have an implementation going it might be good to see if we can do that.
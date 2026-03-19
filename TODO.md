# Comprehensive TODO List for ClimateIndices.jl

## 1. Core Architecture & Types
- [ ] Refine `ClimateIndex` to include rich metadata (units, calculation timestamp, source, etc.).
- [ ] Finalize `AbstractEngine` interface (e.g., dispatch on data types).
- [ ] Support for 3D/4D arrays (lat, lon, time, plus optional vertical/pressure levels).

## 2. Calculation Engines
- [ ] Implement robust `AreaMean` with latitude-weighted averaging.
- [ ] Develop `PointDifference` (e.g., for SOI: Tahiti minus Darwin).
- [ ] Add `RollingAverage` and `Detrending` as composable operations.
- [ ] Support custom weight masks for irregular regions.

## 3. Reference Periods & Anomalies
- [ ] Define standard reference periods (e.g., 1991-2020).
- [ ] Implement anomaly calculation: `value - mean(reference_period)`.
- [ ] Support for seasonally adjusted anomalies.

## 4. Backends & Extensions
- [ ] Create `ERA5` backend extension (loading NetCDF/GRIB data).
- [ ] Define a standard `BackendInterface` to allow users to bring their own data.
- [ ] Support for `Tables.jl` compatible data sources (1D/tidy data).

## 5. Standard Indices Implementation
- [ ] **ENSO/NINO**: Implement NINO3, NINO3.4, NINO4, etc.
- [ ] **SOI**: Implement Southern Oscillation Index.
- [ ] **MJO**: Implement Madden-Julian Oscillation (RMM1, RMM2).
- [ ] **Global Mean**: Implement Global Mean Temperature (GMT) calculation.

## 6. Testing & CI
- [ ] Add unit tests for each engine in `test/runtests.jl`.
- [ ] Set up integration tests with dummy datasets.
- [ ] Configure `Codecov` and `JuliaFormatter` GitHub Actions.

## 7. Documentation
- [ ] Initialize `docs/` using `Documenter.jl`.
- [ ] Write examples for custom index definition.
- [ ] Document the `ClimateIndex` API.

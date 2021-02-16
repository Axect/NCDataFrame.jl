# NCDataFrame.jl

Read & write NetCDF file via [DataFrames](https://github.com/JuliaData/DataFrames.jl).

## Manual

### Install

```julia
using Pkg

Pkg.add(url="https://github.com/Axect/NCDataFrame.jl")
```

### Read

```julia
using NCDataFrame

df = readnc("data.nc") # DataFrame
```

### Write

```julia
using NCDataFrame
using DataFrames

df = DataFrame()
df[!,:x] = 1:10
df[!,:y] = 'a':'j'

writenc(df, "data.nc")
```

## Tips for different length vectors

```julia
using NCDataFrame
using DataFrames

df = DataFrame()

```

## References

NCDataFrame.jl uses two packages inside.

* [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl)
* [NCDatasets.jl](https://github.com/Alexander-Barth/NCDatasets.jl)

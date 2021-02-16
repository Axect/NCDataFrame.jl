# NCDataFrame

Read & write NetCDF file via [DataFrames](https://github.com/JuliaData/DataFrames.jl).

## Install

```julia
using Pkg

Pkg.add(url="https://github.com/Axect/NCDataFrame.jl")
```

## Read

```julia
using NCDataFrame

df = readnc("data.nc")
```

## Write

```julia
using NCDataFrame
using DataFrames

df = DataFrame()
df[!,:x] = 1:10
df[!,:y] = 'a':'j'

writenc(df, "data.nc")
```

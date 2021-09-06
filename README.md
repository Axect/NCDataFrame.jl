# NCDataFrame.jl

Read & write NetCDF file via [DataFrames](https://github.com/JuliaData/DataFrames.jl).

## Manual

### Install

```julia
using Pkg

Pkg.add("NCDataFrame")
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

### Fill missing

```julia
fillmissing(1:3, 5)         # [1,2,3,missing,missing]
fillmissing([1,2,3], 5)     # [1,2,3,missing,missing]
fillmissing(1:5, 5)         # 1:5
fillmissing([1,2,3,4,5], 5) # [1,2,3,4,5]
```

## Tips for different length vectors

```julia
using NCDataFrame
using DataFrames

df = DataFrame()
df[!, :x] = fillmissing(1:3, 5)     # [1,2,3,missing,missing]
df[!, :y] = 1:5                     # [1,2,3,4,5]

writenc(df, "data.nc")              # It works!

dg = readnc("data.nc")              # It works too!
dg[!,:x] |> skipmissing |> collect  # Remove missing from x
```

## Trouble Shooting

**Error on install `NCDatasets`**

For error message such as :

`ERROR: LoadError: InitError: could not load library "$HOME/.julia/artifacts/0a7f440ba143b238cc3dd0def2956d34d76755f3/lib/libnetcdf.so"`

You can solve it by following procedures.

1. Install `libnetcdf`
2. `cd $HOME/.julia/artifacts/0a7f440ba143b238cc3dd0def2956d34d76755f3/lib/`
3. `unlink libnetcdf.so`
4. `unlink libnetcdf.so.18`
5. `ln -s /usr/lib/libnetcdf.so $PWD/libnetcdf.so`
6. `ln -s /usr/lib/libnetcdf.so.18 $PWD/libnetcdf.so.18`
7. In julia, `using NCDataFrame` than finish!

## References

NCDataFrame.jl uses below packages inside.

* [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl)
* [NCDatasets.jl](https://github.com/Alexander-Barth/NCDatasets.jl)
* [Missings.jl](https://github.com/JuliaData/Missings.jl)

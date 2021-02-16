module NCDataFrame

import NCDatasets: Dataset, defDim, defVar, varbyattrib, name
import DataFrames: DataFrame
import Missings: missings

export writenc, readnc, fillmissing

"""
writenc(df, "path/to/data.nc")

Create netcdf file from DataFrame
"""
function writenc(df::DataFrame, path)
    ds = Dataset(path, "c")
    cols = names(df);
    for col in cols
        data = collect(skipmissing(df[:, col]));
        len = length(data);
        defDim(ds, col, len);
        defVar(ds, col, data, (col,));
    end
    close(ds)
end

"""
fillmissing(vec, l)

Return length l vector: [vec..., missing, ... , missing]
"""
function fillmissing(vec::T, len) where {S <: Any, T <: AbstractArray{S}}
    if length(vec) < len
        return vcat(vec, missings(len-length(vec)))
    elseif length(vec) == len
        return vec
    else
        return error("length of vec can't exceed len")
    end
end

"""
df = readnc("path/to/data.nc")

Read netcdf file to DataFrame
"""
function readnc(path)
    ds = Dataset(path, "r")
    cols = map(name, varbyattrib(ds))
    df = DataFrame()
    max_len = 0
    for col in cols
        max_len = max(max_len, length(ds[col][:]))
    end
    for col in cols
        df[!,col] = fillmissing(ds[col][:], max_len)
    end
    return df
end

end # module

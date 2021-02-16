module NCDataFrame

import NCDatasets: Dataset, defDim, defVar, varbyattrib, name
import DataFrames: DataFrame

export writenc, readnc

"""
writenc(df, "path/to/data.nc")

Create netcdf file from DataFrame
"""
function writenc(df::DataFrame, path)
    ds = Dataset(path, "c")
    cols = names(df);
    for col in cols
        data = df[:, col];
        #ty = eltype(data);
        len = length(data);
        defDim(ds, col, len);
        defVar(ds, col, data, (col,));
    end
    close(ds)
end

"""
df = readnc("path/to/data.nc")

Read netcdf file to DataFrame
"""
function readnc(path)
    ds = Dataset(path, "r")
    cols = map(name, varbyattrib(ds))
    df = DataFrame()
    for col in cols
        df[!,col] = ds[col][:]
    end
    return df
end

end # module

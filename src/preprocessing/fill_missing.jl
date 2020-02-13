include("scaler.jl")
using DataFrames

export fill_missing_aggregate
export fill_missing_scalar

"""
_given a dataframe and optionally columns, return the dataframe with missing values filled in with column's mean, median, etc._
#### parameters:
    data : DataFrame
        dataframe to min max scale
    columns : Array{Symbol}
        an array of column names to scale, default is all numeric
    method : Function
        [mean, median, mode], or any desired function that operates on an array and returns a single value
#### returns: DataFrame
    a new dataframe with desired columns altered
"""
function fill_missing_aggregate(data::DataFrame, columns::Array=[]; method)
    tmp = copy(data)
    numeric_cols = numeric_columns(tmp)
    iter_columns = isempty(columns) ? numeric_cols :
                   intersect(numeric_cols, Symbol.(columns))
    for col in iter_columns
        tmp[!, Symbol(col)] = recode(tmp[!, Symbol(col)], missing => method(skipmissing(tmp[!, Symbol(col)])))
    end
    return tmp
end

"""
_given a dataframe and optionally columns, return the dataframe with missing values filled in with provided scalar_
#### parameters:
    data : DataFrame
        dataframe to min max scale
    columns : Array{Symbol}
        an array of column names to scale, default is all numeric
    scalar : Any
        any desired value to replace missings, must be of type of column(s)
#### returns: DataFrame
    a new dataframe with desired columns altered
"""
function fill_missing_scalar(data::DataFrame, columns::Array=[]; scalar::Any)
    tmp = copy(data)
    iter_columns = isempty(columns) ? names(tmp) :
                   intersect(names(tmp), Symbol.(columns))
    for col in iter_columns
        try
            tmp[!, Symbol(col)] = recode(tmp[!, Symbol(col)], missing => scalar)
        catch e
            throw(ArgumentError("Scalar must match variable type of ALL columns."))
        end
    end
    return tmp
end

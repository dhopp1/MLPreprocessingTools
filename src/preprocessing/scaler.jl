using DataFrames

export min_max_scaler

"""
_given a dataframe and optionally columns, return the dataframe with numeric columns min max scaled_
#### parameters:
    data : DataFrame
        dataframe to min max scale
    columns : Array{Symbol}
        an array of column names to scale, default is all numeric
    scale_min : Float64
        the minimum scale, default 0.0
    scale_max : Float64
        the maximum scale, default 1.0
#### returns: DataFrame
    a new dataframe with desired columns min max scaled
"""
function min_max_scaler(
    data::DataFrame,
    columns::Array = [];
    scale_min::Number = 0.0,
    scale_max::Number = 1.0,
)
    tmp = copy(test_data)
    numeric_cols = tmp[
        !,
        (<:).(eltype.(eachcol(tmp)), Union{Number,Missing}),
    ] |> names
    iter_columns = isempty(columns) ? numeric_cols :
                   intersect(numeric_cols, Symbol.(columns))
    for col in iter_columns
        tmp[!, Symbol(col)] = ((tmp[!, Symbol(col)] .-
                                minimum(skipmissing(tmp[!, Symbol(col)]))) /
                               (maximum(skipmissing(tmp[!, Symbol(col)])) -
                                minimum(skipmissing(tmp[!, Symbol(col)])))) .*
                              (scale_max - scale_min) .+ scale_min
    end
    return tmp
end

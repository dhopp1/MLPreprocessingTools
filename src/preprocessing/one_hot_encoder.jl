using DataFrames

export one_hot_encoder

"""
_given a dataframe and a column, return the dataframe with the unique values of the column added as new columns to the dataframe_
#### parameters:
    data : DataFrame
        dataframe to apply one hot encoder
    column : Symbol or String
        column to one hot encode
    prefix : String
        the name to prefix to the new columns, default to the name of the original column
    remove_original: Boolean
        whether or not to remove the original column from the dataframe
#### returns: DataFrame
    a new dataframe with one hot encoded columns added
"""
function one_hot_encoder(data::DataFrame, column; prefix=missing, remove_original=true)
    tmp = copy(data)
    column = Symbol(column)
    prefix = ismissing(prefix) ? string(column) : prefix
    possibilities = unique(tmp[!, column])
    col_names = prefix .* "_" .* string.(possibilities)
    for i in 1:length(possibilities)
        tmp[!, Symbol(col_names[i])] .= 0
        tmp[tmp[!, column] .== possibilities[i], Symbol(col_names[i])] .= 1
    end
    if remove_original select!(tmp, Not(column)) end
    return tmp
end

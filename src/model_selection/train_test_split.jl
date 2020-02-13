using DataFrames, Random

export partition_train_test
export train_test_split

"given a dataframe, split it into two random parts based on the at ratio"
function partition_train_test(data::DataFrame, at=0.66, seed=rand(1:1000))
    Random.seed!(seed)
    n = nrow(data)
    idx = shuffle(1:n)
    train_idx = view(idx, 1:floor(Int, at*n))
    test_idx = view(idx, (floor(Int, at*n)+1):n)
    data[train_idx,:], data[test_idx,:]
end

"""
_given a dataframe, split it to train and test groups_
#### parameters:
    data : DataFrame
        dataframe to split
    target_col : String or Symbol
        target variable
    train_share
#### returns: DataFrame
    a new dataframe with one hot encoded columns added
"""
function train_test_split(X::DataFrame, target_col::String; train_share=0.66, seed=rand(1:1000))
    train,test = partition_train_test(X, train_share, seed)
    X_train = select(train, Not(Symbol(target_col)))
    y_train = train[!, Symbol(target_col)]
    X_test = select(test, Not(Symbol(target_col)))
    y_test = test[!, Symbol(target_col)]
    return X_train, X_test, y_train, y_test
end

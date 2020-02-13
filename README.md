# MLPreprocessingTools
Collection of tools useful for data cleaning or processing using DataFrames.jl

### Installation
```julia
using Pkg
Pkg.add(PackageSpec(url="https://github.com/dhopp1/MLPreprocessingTools.jl"))
using BinaryClassificationTools
```
### Model Selection
- `train_test_split`

### Preprocessing
- `min_max_scaler`: scale columns of a dataframe to min and max of the column
- `standard_scaler`: scale columns of a dataframe to unit variance less mean: `(x - mean) / std`
- `fill_missing_aggregate`: fill missing values of a dataframe with an aggregate value of the column (e.g. mean)
- `fill_missing_scalar`: fill missing values of a dataframe with a scalar value
- `one_hot_encoder`: convert a column of a dataframe to multiple columns via one hot encoding
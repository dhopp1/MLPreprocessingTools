include("../../src/model_selection/train_test_split.jl")
using Test, DataFrames, Random

test = DataFrame(
    x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    y = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
)

@testset "train test split" begin
    @test isequal(
        partition_train_test(test, 0.5, 42)[1],
        DataFrame(x = [7, 3, 5, 6, 9], y = [7, 3, 5, 6, 9]),
    )
    @test isequal(
        train_test_split(test, "y", seed = 42)[1],
        DataFrame(x = [7, 3, 5, 6, 9, 8]),
    )
    @test isequal(
        train_test_split(test, "y", seed = 42)[2],
        DataFrame(x = [2, 1, 10, 4]),
    )
    @test isequal(train_test_split(test, "y", seed = 42)[3], [7, 3, 5, 6, 9, 8])
    @test isequal(train_test_split(test, "y", seed = 42)[4], [2, 1, 10, 4])
    @test isequal(
        train_test_split(test, "y", train_share = 0.5, seed = 42)[1],
        DataFrame(x = [7, 3, 5, 6, 9]),
    )
end

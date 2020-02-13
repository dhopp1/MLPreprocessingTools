include("../../src/preprocessing/one_hot_encoder.jl")
using Test, DataFrames

test_data = DataFrame(
    x = ["one", "two", "three", "four"],
    y = [1.0, 2.0, 2.0, 2.0]
)

@testset "one_hot_encoder" begin
    # string column
    @test isequal(one_hot_encoder(test_data, "x"), DataFrame(
        y = [1.0, 2.0, 2.0, 2.0],
        x_one = [1, 0, 0, 0],
        x_two = [0, 1, 0, 0],
        x_three = [0, 0, 1, 0],
        x_four = [0, 0, 0, 1]
    ))
    # symbol column
    @test isequal(one_hot_encoder(test_data, :x), DataFrame(
        y = [1.0, 2.0, 2.0, 2.0],
        x_one = [1, 0, 0, 0],
        x_two = [0, 1, 0, 0],
        x_three = [0, 0, 1, 0],
        x_four = [0, 0, 0, 1]
    ))
    # different prefix
    @test isequal(one_hot_encoder(test_data, "x", prefix="new"), DataFrame(
        y = [1.0, 2.0, 2.0, 2.0],
        new_one = [1, 0, 0, 0],
        new_two = [0, 1, 0, 0],
        new_three = [0, 0, 1, 0],
        new_four = [0, 0, 0, 1]
    ))
    # decimals in values
    @test isequal(
        one_hot_encoder(test_data, "y", prefix="new"),
        DataFrame(
            x = ["one", "two", "three", "four"],
            one = [1, 0, 0, 0],
            two = [0, 1, 1, 1]
        ) |> x -> rename!(x, [:x, Symbol("new_1.0"), Symbol("new_2.0")])
    )
    # remove original = false
    @test isequal(one_hot_encoder(test_data, "x", remove_original=false), DataFrame(
        x = ["one", "two", "three", "four"],
        y = [1.0, 2.0, 2.0, 2.0],
        x_one = [1, 0, 0, 0],
        x_two = [0, 1, 0, 0],
        x_three = [0, 0, 1, 0],
        x_four = [0, 0, 0, 1]
    ))
end

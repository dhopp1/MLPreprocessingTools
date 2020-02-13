include("../../src/preprocessing/scaler.jl")
using Test, DataFrames

test_data = DataFrame(
    w = ["one", "two", "three", "four"],
    x = [1, 2, 3, missing],
    y = [15, 45, 90, 15],
    z = [-1, -20, 20, -20],
)

@testset "scaler" begin
    # all columns
    @test isequal(min_max_scaler(test_data), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [0.0, 0.5, 1.0, missing],
        y = [0.0, 0.4, 1.0, 0.0],
        z = [0.475, 0.0, 1.0, 0.0]
    ))
    # subset of columns
    @test isequal(min_max_scaler(test_data, [:x, :y]), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [0.0, 0.5, 1.0, missing],
        y = [0.0, 0.4, 1.0, 0.0],
        z = [-1, -20, 20, -20]
    ))
    # subset of columns as strings
    @test isequal(min_max_scaler(test_data, ["x", "y"]), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [0.0, 0.5, 1.0, missing],
        y = [0.0, 0.4, 1.0, 0.0],
        z = [-1, -20, 20, -20]
    ))
    # subset of columns + customer scaler
    @test isequal(min_max_scaler(test_data, [:x, :y], scale_min=-100, scale_max=100), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [-100, 0.0, 100.0, missing],
        y = [-100.0, -20.0, 100.0, -100.0],
        z = [-1, -20, 20, -20]
    ))
end

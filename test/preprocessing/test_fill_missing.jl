include("../../src/preprocessing/fill_missing.jl")
using Test, DataFrames, Statistics

test_data = DataFrame(
    w = ["one", "two", "three", "four"],
    x = [1, 2, 3, missing],
    y = [15, missing, 90, 15],
    z = [-1, -20, 20, -20]
)

@testset "fill_missing" begin
    # mean, all columns
    @test isequal(fill_missing_aggregate(test_data, method=mean), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [1.0, 2.0, 3.0, 2.0],
        y = [15.0, 40.0, 90.0, 15.0],
        z = [-1.0, -20.0, 20.0, -20.0]
    ))
    # mode, all columns
    @test isequal(fill_missing_aggregate(test_data, method=median), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [1.0, 2.0, 3.0, 2.0],
        y = [15.0, 15.0, 90.0, 15.0],
        z = [-1.0, -20.0, 20.0, -20.0]
    ))
    # mean, subset of columns
    @test isequal(fill_missing_aggregate(test_data, [:y, :z],method=mean), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [1, 2, 3, missing],
        y = [15.0, 40.0, 90.0, 15.0],
        z = [-1.0, -20.0, 20.0, -20.0]
    ))

    # scalar, correct type
    @test isequal(fill_missing_scalar(test_data, [:x, :y], scalar=100), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [1, 2, 3, 100],
        y = [15, 100, 90, 15],
        z = [-1, -20, 20, -20]
    ))
    # scalar, incorrect type
    @test try
            fill_missing_scalar(test_data, [:x, :y], scalar="string")
        catch ex
            ex
        end == ArgumentError("Scalar must match variable type of ALL columns.")
end

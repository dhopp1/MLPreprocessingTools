include("../../src/preprocessing/scaler.jl")
using Test, DataFrames

test_data = DataFrame(
    w = ["one", "two", "three", "four"],
    x = [1, 2, 3, missing],
    y = [15, 45, 90, 15],
    z = [-1, -20, 20, -20],
)

@testset "min_max_scaler" begin
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
    # subset of columns + custom scaler
    @test isequal(min_max_scaler(test_data, [:x, :y], scale_min=-100, scale_max=100), DataFrame(
        w = ["one", "two", "three", "four"],
        x = [-100, 0.0, 100.0, missing],
        y = [-100.0, -20.0, 100.0, -100.0],
        z = [-1, -20, 20, -20]
    ))
end

@testset "standard_scaler" begin
    # all columns
    @test isequal(standard_scaler(test_data).w, ["one", "two", "three", "four"])
    @test isequal(standard_scaler(test_data).x, [-1.0, 0.0, 1.0, missing])
    @test isequal(round.(standard_scaler(test_data).y, digits=4), [-0.7406, 0.1058, 1.3754, -0.7406])
    @test isequal(round.(standard_scaler(test_data).z, digits=4), [0.2229, -0.7736, 1.3242, -0.7736])

    # subset of columns
    @test isequal(standard_scaler(test_data, [:x, :y]).w, ["one", "two", "three", "four"])
    @test isequal(standard_scaler(test_data, [:x, :y]).x, [-1.0, 0.0, 1.0, missing])
    @test isequal(round.(standard_scaler(test_data, [:x, :y]).y, digits=4), [-0.7406, 0.1058, 1.3754, -0.7406])
    @test isequal(round.(standard_scaler(test_data, [:x, :y]).z, digits=4), [-1, -20, 20, -20])

    # subset of columns as strings
    @test isequal(standard_scaler(test_data, ["x", "y"]).w, ["one", "two", "three", "four"])
    @test isequal(standard_scaler(test_data, ["x", "y"]).x, [-1.0, 0.0, 1.0, missing])
    @test isequal(round.(standard_scaler(test_data, ["x", "y"]).y, digits=4), [-0.7406, 0.1058, 1.3754, -0.7406])
    @test isequal(round.(standard_scaler(test_data, ["x", "y"]).z, digits=4), [-1, -20, 20, -20])
end

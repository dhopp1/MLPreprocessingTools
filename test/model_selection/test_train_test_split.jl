using Test
include("../../src/model_selection/train_test_split.jl")

@testset "train test split" begin
    @test true_positives(data_actual, data_pred) == 4.0
end

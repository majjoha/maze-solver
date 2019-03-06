# frozen_string_literal: true

require_relative "../../spec_helper"

describe GAMaze::Genome do
  describe "#manhattan_distance" do
    let(:genome) do
      GAMaze::Genome.new(
        current_position: [5, 1],
        goal: [5, 4]
      )
    end

    it "calculates the Manhattan distance" do
      expect(genome.manhattan_distance).to eq(3)
    end
  end

  describe "#add_move" do
    let(:genome) { GAMaze::Genome.new }

    it "adds the move to the path" do
      genome.add_move(:up)
      expect(genome.path).to eq([:up])
    end
  end

  describe "#fitness" do
    let(:genome) { GAMaze::Genome.new(current_position: [5, 1], goal: [5, 1]) }

    it "calculates the fitness" do
      expect(genome.fitness).to eq(0)
    end
  end
end

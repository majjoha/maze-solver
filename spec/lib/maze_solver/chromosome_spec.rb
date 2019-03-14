# frozen_string_literal: true

require_relative "../../spec_helper"

describe MazeSolver::Chromosome do
  describe "#add_move" do
    let(:chromosome) { described_class.new }

    it "adds the move to the path" do
      chromosome.add_move(:up)
      expect(chromosome.moves).to eq([:up])
    end
  end

  describe "#fitness" do
    let(:chromosome) do
      described_class.new(positions: [[5, 1]], goal: [5, 1])
    end

    it "calculates the fitness" do
      expect(chromosome.fitness).to eq(0)
    end
  end

  describe "#manhattan_distance" do
    let(:chromosome) do
      described_class.new(
        positions: [[5, 1]],
        goal: [5, 4]
      )
    end

    it "calculates the Manhattan distance" do
      expect(chromosome.manhattan_distance).to eq(3)
    end
  end
end

# frozen_string_literal: true

require_relative "../../spec_helper"

describe MazeSolver::Population do
  let(:first_chromosome) do
    MazeSolver::Chromosome.new(penalties: 0, positions: [[5, 1]])
  end
  let(:second_chromosome) do
    MazeSolver::Chromosome.new(penalties: 100, positions: [[5, 1]])
  end
  let(:offspring) do
    MazeSolver::Chromosome.new(penalties: 25, positions: [[5, 1]])
  end
  let(:population) do
    described_class.new(
      individuals: [first_chromosome, second_chromosome]
    )
  end

  describe "#replace_worst_individuals_with" do
    it "removes the worst N individuals and replaces them with offsprings" do
      expect(
        population.replace_worst_individuals_with(
          [offspring], amount: 1
        ).individuals
      ).to eq([first_chromosome, offspring])
    end
  end
end

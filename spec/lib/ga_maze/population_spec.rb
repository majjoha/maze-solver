# frozen_string_literal: true

require_relative "../../spec_helper"

describe GAMaze::Population do
  let(:first_genome) { GAMaze::Genome.new(penalties: 0) }
  let(:second_genome) { GAMaze::Genome.new(penalties: 100) }
  let(:offspring) { GAMaze::Genome.new(penalties: 25) }
  let(:population) do
    GAMaze::Population.new(individuals: [first_genome, second_genome])
  end

  describe "#worst_individuals" do
    it "sorts the individuals by highest fitness score first" do
      expect(population.worst_individuals).to eq([second_genome, first_genome])
    end
  end

  describe "#best_individuals" do
    it "sorts the individuals by the lowest fitness score first" do
      expect(population.best_individuals).to eq([first_genome, second_genome])
    end
  end

  describe "#replace_worst_individuals_with" do
    it "removes the worst N individuals and replaces them with offsprings" do
      expect(
        population.replace_worst_individuals_with([offspring], amount: 1)
      ).to eq([first_genome, offspring])
    end
  end
end

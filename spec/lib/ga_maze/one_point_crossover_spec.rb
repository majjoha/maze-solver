# frozen_string_literal: true

require_relative "../../spec_helper"

describe MazeSolver::OnePointCrossover do
  let(:crossover_point) { 5 }
  let(:first_genes) { [0, 4, 3, 0, 1, 2, 4, 3, 4, 1] }
  let(:second_genes) { [1, 4, 3, 1, 2, 4, 0, 2, 1, 0] }
  let(:offspring_genes) { [0, 4, 3, 0, 1, 4, 0, 2, 1, 0] }
  let(:first_parent) { MazeSolver::Chromosome.new(genes: first_genes) }
  let(:second_parent) { MazeSolver::Chromosome.new(genes: second_genes) }
  let(:offspring) { MazeSolver::Chromosome.new(genes: offspring_genes) }

  describe ".perform_crossover" do
    it "performs a one point crossover on two parents" do
      expect(
        MazeSolver::OnePointCrossover.perform_crossover(
          first_parent: first_parent,
          second_parent: second_parent,
          crossover_point: crossover_point
        ).genes
      ).to eq(offspring.genes)
    end
  end
end

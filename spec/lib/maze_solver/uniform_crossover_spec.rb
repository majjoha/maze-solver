# frozen_string_literal: true

require_relative "../../spec_helper"

describe MazeSolver::UniformCrossover do
  let(:points) { [1, 1, 0, 0, 1, 1, 0, 1, 1, 0] }
  let(:first_genes) { [0, 4, 3, 0, 1, 2, 4, 3, 4, 1] }
  let(:second_genes) { [1, 4, 3, 1, 2, 4, 0, 2, 1, 0] }
  let(:offspring_genes) { [1, 4, 3, 0, 2, 4, 4, 2, 1, 1] }

  describe ".perform_crossover" do
    let(:first_parent) { instance_double("chromosome") }
    let(:second_parent) { instance_double("chromosome") }
    let(:offspring) { instance_double("chromosome") }

    it "performs a uniform crossover on two parents" do
      allow(first_parent).to receive(:genes).and_return(first_genes)
      allow(second_parent).to receive(:genes).and_return(second_genes)
      allow(offspring).to receive(:genes).and_return(offspring_genes)

      expect(
        described_class.perform_crossover(
          first_parent: first_parent,
          second_parent: second_parent,
          points: points
        ).genes
      ).to eq(offspring.genes)
    end
  end
end

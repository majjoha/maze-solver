# frozen_string_literal: true

require_relative "genome"

module GAMaze
  class OnePointCrossover
    def self.perform_crossover(
      first_parent:,
      second_parent:,
      crossover_point: Random.rand(Genome::GENE_LENGTH)
    )

      Genome.new(
        genes: first_parent.genes[0...crossover_point].concat(
          second_parent.genes[crossover_point..Genome::GENE_LENGTH]
        )
      )
    end
  end
end

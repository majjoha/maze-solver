# frozen_string_literal: true

module MazeSolver
  class OnePointCrossover
    def self.perform_crossover(
      first_parent:,
      second_parent:,
      crossover_point: Random.rand(Chromosome::GENE_LENGTH)
    )
      Chromosome.new(
        genes: first_parent.genes[0...crossover_point].concat(
          second_parent.genes[crossover_point..Chromosome::GENE_LENGTH]
        )
      )
    end
  end
end

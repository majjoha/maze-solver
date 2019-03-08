# frozen_string_literal: true

module MazeSolver
  class UniformCrossover
    def self.perform_crossover(
      first_parent:,
      second_parent:,
      points: Array.new(Chromosome::GENE_LENGTH) { Random.rand(2) }
    )
      genes = points.map.with_index do |point, index|
        if point.zero?
          first_parent.genes[index]
        else
          second_parent.genes[index]
        end
      end

      Chromosome.new(genes: genes)
    end
  end
end

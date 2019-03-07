# frozen_string_literal: true

require_relative "genome"

module GAMaze
  class UniformCrossover
    def self.perform_crossover(
      first_parent:,
      second_parent:,
      points: Array.new(Genome::GENE_LENGTH) { Random.rand(2) }
    )
      genes = points.map.with_index do |point, index|
        if point.zero?
          first_parent.genes[index]
        else
          second_parent.genes[index]
        end
      end

      Genome.new(genes: genes)
    end
  end
end

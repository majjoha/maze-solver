# frozen_string_literal: true

require_relative "genome"

module GAMaze
  class Population
    def initialize(individuals: Array.new(POPULATION_SIZE) { Genome.new })
      @individuals = individuals
    end

    def fittest
      population.min
    end

    def worst_individuals
      individuals.sort.reverse
    end

    def best_individuals
      individuals.sort
    end

    def replace_worst_individuals_with(offsprings, amount: INDIVIDUALS_TO_KEEP)
      individuals.sort.take(amount).concat(offsprings)
    end

    def calculate_fitness
      individuals.each {|individual| Maze.new(genome: individual) }.run
    end

    attr_accessor :individuals

    POPULATION_SIZE = 10_000
    OFFSPRING_RATIO = 0.25
    OFFSPRINGS = POPULATION_SIZE * OFFSPRING_RATIO
    INDIVIDUALS_TO_KEEP = POPULATION_SIZE - OFFSPRINGS + 1
  end
end

# frozen_string_literal: true

module MazeSolver
  class Population
    def initialize(individuals: Array.new(POPULATION_SIZE) { Chromosome.new })
      @individuals = individuals
    end

    def fittest
      individuals.min
    end

    def best_individuals
      individuals.sort
    end

    def replace_worst_individuals_with(offsprings, amount: INDIVIDUALS_TO_KEEP)
      Population.new(
        individuals: best_individuals.take(amount).concat(offsprings)
      )
    end

    def calculate_fitness
      individuals.each do |individual|
        MazeNavigator.new(chromosome: individual).run
      end
    end

    def produce_offsprings
      individuals.each_cons(2).map do |parents|
        chromosome = Chromosome.new_from_parents(parents: parents)
        chromosome.mutate! if should_mutate?
        chromosome
      end
    end

    def worst_individuals
      best_individuals.reverse
    end

    attr_accessor :individuals

    private

    def should_mutate?
      Random.rand(100) <= MUTATION_PROBABILITY
    end

    POPULATION_SIZE = 500
    OFFSPRING_RATIO = 0.25
    OFFSPRINGS = POPULATION_SIZE * OFFSPRING_RATIO
    INDIVIDUALS_TO_KEEP = POPULATION_SIZE - OFFSPRINGS + 1
    MUTATION_PROBABILITY = 20
  end
end

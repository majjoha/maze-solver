# frozen_string_literal: true

require "logger"
require_relative "genome"
require_relative "population"

module GAMaze
  class Algorithm
    def initialize(
      fittest: Genome.new,
      generations: 0,
      logger: Logger.new(STDOUT),
      population: Population.new,
      second_fittest: Genome.new
    )
      @fittest = fittest
      @generations = generations
      @logger = logger
      @population = population
      @second_fittest = second_fittest
    end

    def run
      while population.fitness < 50
        @generations += 1

        # Find the two best performing individuals
        selection

        # Perform a crossover on them
        crossover

        # Mutate if the mutation rate is less than or equal to 20 percent
        mutation if should_mutate?

        # Replace the worst fitting individual with the best fitting individual
        add_fittest_offspring

        # Calculate the currect fitness of the population
        population.find_fittest

        logger.info(
          "Generation: #{generations}. Fittest: #{population.fitness}"
        )
      end

      logger.info("Solution found in generation #{generations}")
      logger.info(population.find_fittest)
    end

    def selection
      @fittest = population.find_fittest
      @second_fittest = population.find_second_fittest
    end

    attr_accessor :fittest, :generations, :logger, :population, :second_fittest

    private

    def should_mutate?
      Random.rand(100) <= MUTATION_RATE
    end

    def find_fittest_offspring
      return fittest if fittest > second_fittest

      second_fittest
    end

    def add_fittest_offspring
      worst_fitness_index = population.find_worst_fitting_index
      @population.individuals[worst_fitness_index] = find_fittest_offspring
    end

    def mutation
      mutation_point = Random.rand(Genome::GENE_LENGTH)

      @fittest.genes[mutation_point] = Random.rand(5)

      # if fittest.genes[mutation_point].zero?
      #   @fittest.genes[mutation_point] = 1
      # else
      #   @fittest.genes[mutation_point] = 0
      # end

      # mutation_point = Random.rand(Genome::GENE_LENGTH)

      # if second_fittest.genes[mutation_point].zero?
      #   @second_fittest.genes[mutation_point] = 1
      # else
      #   @second_fittest.genes[mutation_point] = 0
      # end
    end

    def crossover
      crossover_point = Random.rand(Genome::GENE_LENGTH)

      Array.new(crossover_point).each_with_index do |_, i|
        temp = fittest.genes[i]
        @fittest.genes[i] = second_fittest.genes[i]
        @second_fittest.genes[i] = temp
      end
    end

    MUTATION_RATE = 20
  end
end

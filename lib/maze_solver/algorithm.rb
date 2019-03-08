# frozen_string_literal: true

require "logger"

module MazeSolver
  class Algorithm
    def initialize(
      population: Population.new,
      fittest: Chromosome.new,
      generation: 0,
      debug: true,
      logger: Logger.new(STDOUT)
    )
      @population = population
      @fittest = fittest
      @generation = generation
      @debug = debug
      @logger = logger
    end

    def run
      loop do
        @generation += 1

        logger.info(status(generation: generation)) if debug

        return fittest if fittest.manhattan_distance == 1

        @fittest = population.fittest

        # Calculate fitness for each individual
        population.calculate_fitness

        # Mutation and crossover
        offsprings = population.produce_offsprings

        # Replace old population
        @population = population.replace_worst_individuals_with(offsprings)
      end
    end

    attr_accessor :population, :fittest, :generation, :debug, :logger

    private

    def status(generation:)
      "Generation #{generation.to_s.ljust(4)}\tChampion: #{fittest}"
    end
  end
end

# frozen_string_literal: true

require "logger"
require_relative "genome"
# require_relative "population"

module GAMaze
  class Algorithm
    def initialize(
      population: Array.new(POPULATION_SIZE) { Genome.new },
      fittest: Genome.new,
      generation: 0,
      crossover_strategy: UniformCrossover,
      debug: false,
      logger: Logger.new(STDOUT)
    )
      @population = population
      @fittest = fittest
      @generation = generation
      @crossover_strategy = crossover_strategy
      @debug = debug
      @logger = logger
    end

    def run
      loop do
        @generation += 1

        break if fittest.manhattan_distance == 1

        # Calculate fitness for each individual
        population.each { |individual| Maze.new(genome: individual).run }

        # Selection
        @fittest = population.min
        logger.info(
          "Generation: #{generation.to_s.ljust(5)}\t\tFittest: #{fittest.inspect}"
        )

        # Mutation and crossover
        offsprings = produce_offsprings.each do |offspring|
          offspring.mutate! if should_mutate?
        end

        # Replace worst fitting individual with offspring
        @population = replace_worst_individuals_with(offsprings)
      end
      fittest
    end

    attr_accessor :population, :fittest, :generation,
      :crossover_strategy, :debug, :logger

    private

    def produce_offspring(first_parent:, second_parent:)
      Genome.new_from_parents(parents: [first_parent, second_parent])
    end

    def produce_offsprings
      best_individuals.each_cons(2).map do |first_parent, second_parent|
        produce_offspring(
          first_parent: first_parent, second_parent: second_parent
        )
      end
    end

    def replace_worst_individuals_with(offsprings)
      population
        .sort
        .take(POPULATION_SIZE - OFFSPRINGS + 1)
        .concat(offsprings)
    end

    def best_individuals
      population.sort.take(OFFSPRINGS)
    end

    def worst_individuals
      population.sort.reverse
    end

    def should_mutate?
      Random.rand(100) <= MUTATION_PROBABILITY
    end

    MUTATION_PROBABILITY = 20
    POPULATION_SIZE = 1000
    OFFSPRING_RATIO = 0.25
    OFFSPRINGS = POPULATION_SIZE * OFFSPRING_RATIO
  end
end

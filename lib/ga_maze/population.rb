# frozen_string_literal: true

require_relative "genome"

module GAMaze
  class Population
    def initialize(individuals: Array.new(POPULATION_SIZE) { Genome.new })
      @individuals = individuals
      @fitness = 0
    end

    def find_fittest
      max_fit = -Float::INFINITY
      max_fit_index = 0

      individuals.each_with_index do |individual, index|
        if max_fit >= individual.fitness
          max_fit = individual.fitness
          max_fit_index = index
        end
      end

      @fitness = individuals[max_fit_index].fitness
      individuals[max_fit_index]
    end

    def find_second_fittest
      best = 0
      second_best = 0

      individuals.each_with_index do |individual, index|
        if individual.fitness < individuals[best].fitness
          best = index
          second_best = individuals[best]
        else
          second_best = index
        end
      end

      individuals[second_best]
    end

    def find_worst_fitting_index
      min_fit_val = Float::INFINITY
      min_fit_index = 0

      individuals.each_with_index do |individual, index|
        if min_fit_val <= individual.fitness
          min_fit_val = individual.fitness
          min_fit_index = index
        end
      end

      min_fit_index
    end

    attr_accessor :individuals, :fitness

    POPULATION_SIZE = 10_000
  end
end

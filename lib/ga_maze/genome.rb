# frozen_string_literal: true

module GAMaze
  class Genome
    include Comparable

    def initialize(
      current_position: START_POSITION,
      genes: Array.new(GENE_LENGTH) { MOVES.keys.sample },
      path: [],
      penalties: 0,
      goal: GOAL
    )
      @current_position = current_position
      @genes = genes
      @path = path
      @penalties = penalties
      @goal = goal
    end

    def self.new_from_parents(parents:, strategy: UniformCrossover)
      strategy.perform_crossover(
        first_parent: parents[0],
        second_parent: parents[1]
      )
    end

    def add_move(direction)
      path << direction
    end

    def update_position(column, row)
      @current_position = [column, row]
    end

    def fitness
      manhattan_distance + penalties
    end

    def manhattan_distance
      (goal[0] - current_position[0]).abs + (goal[1] - current_position[1]).abs
    end

    def steps
      path.length
    end

    def <=>(other)
      fitness <=> other.fitness
    end

    def inspect
      "Fitness: #{fitness}. Manhattan distance: #{manhattan_distance}"
    end

    def mutate!(mutation_point: Random.rand(GENE_LENGTH + 1))
      @genes[mutation_point] = MOVES.keys.sample
    end

    attr_accessor :current_position, :genes, :path, :penalties, :goal

    GENE_LENGTH = 100
    GOAL = [8, 13].freeze
    START_POSITION = [5, 1].freeze
    MOVES = {
      0 => :wall,
      1 => :move_up,
      2 => :move_down,
      3 => :move_right,
      4 => :move_left
    }.freeze
  end
end

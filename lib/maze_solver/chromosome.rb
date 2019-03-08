# frozen_string_literal: true

module MazeSolver
  class Chromosome
    include Comparable

    def initialize(
      positions: [START_POSITION],
      genes: Array.new(GENE_LENGTH) { MOVES.keys.sample },
      moves: [],
      penalties: 0,
      goal: GOAL
    )
      @positions = positions
      @genes = genes
      @moves = moves
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
      moves << direction
    end

    def current_position
      positions.last
    end

    def update_position(column, row)
      positions << [column, row]
    end

    def fitness
      manhattan_distance + penalties
    end

    def manhattan_distance
      (goal[0] - current_position[0]).abs + (goal[1] - current_position[1]).abs
    end

    def mutate!(mutation_point: Random.rand(GENE_LENGTH + 1))
      @genes[mutation_point] = MOVES.keys.sample
    end

    def steps
      moves.length
    end

    def <=>(other)
      fitness <=> other.fitness
    end

    def to_s
      "[Fitness: #{fitness} | " \
      "Manhattan distance: #{manhattan_distance} | " \
      "Steps: #{steps} | " \
      "Penalties: #{penalties}]"
    end

    def inspect
      to_s
    end

    attr_accessor :positions, :genes, :moves, :penalties, :goal

    GENE_LENGTH = 50
    GOAL = [8, 13].freeze
    START_POSITION = [8, 1].freeze
    MOVES = {
      0 => :wall,
      1 => :move_up,
      2 => :move_down,
      3 => :move_right,
      4 => :move_left
    }.freeze
  end
end

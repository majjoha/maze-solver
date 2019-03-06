# frozen_string_literal: true

module GAMaze
  class Genome
    include Comparable

    def initialize(
      current_position: [5, 1],
      genes: Array.new(GENE_LENGTH) { MOVES.keys.sample },
      path: [],
      penalties: 0,
      goal: [0, 0]
    )
      @current_position = current_position
      @genes = genes
      @path = path
      @penalties = penalties
      @goal = goal
    end

    def add_move(direction)
      path << direction
    end

    def update_position(column, row)
      @current_position = [column, row]
    end

    def fitness
      manhattan_distance + steps + penalties
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
      "Fitness: #{fitness}. Genes: #{genes}"
    end

    attr_accessor :current_position, :genes, :path, :penalties, :goal

    GENE_LENGTH = 100
    MOVES = {
      1 => :up,
      2 => :down,
      3 => :right,
      4 => :left
    }.freeze
  end
end

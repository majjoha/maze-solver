# frozen_string_literal: true

require "byebug"
require "json"

module GAMaze
  class Maze
    def initialize(
      board: generate_board,
      completed: false,
      genome: Genome.new,
      path: []
    )
      @board = board
      @completed = completed
      @genome = genome
      @path = path
    end

    def run
      genome.genes.reject(&:zero?).each {|gene| send(Genome::MOVES[gene]) }
    end

    def completed?
      completed
    end

    def move_up
      return if wall?(board[column - 1][row])
      return if goal?(board[column - 1][row])

      board[column][row] = " "
      board[column - 1][row] = PLAYER
      genome.update_position(column - 1, row)
      genome.add_move(:up)
    end

    def move_down
      return if wall?(board[column + 1][row])
      return if goal?(board[column + 1][row])

      board[column][row] = " "
      board[column + 1][row] = PLAYER
      genome.update_position(column + 1, row)
      genome.add_move(:down)
    end

    def move_left
      return if wall?(board[column][row - 1])
      return if goal?(board[column][row - 1])

      board[column][row] = " "
      board[column][row - 1] = PLAYER
      genome.update_position(column, row - 1)
      genome.add_move(:left)
    end

    def move_right
      return if wall?(board[column][row + 1])
      return if goal?(board[column][row + 1])

      board[column][row] = " "
      board[column][row + 1] = PLAYER
      genome.update_position(column, row + 1)
      genome.add_move(:right)
    end

    def to_s
      board.map {|row| row.join(" ") }
    end

    attr_accessor :board, :completed, :genome, :id, :path

    private

    def wall?(cell)
      if cell == WALL
        @genome.penalties += 1
        @genome.add_move(:wall)
        return true
      end

      false
    end

    def goal?(cell)
      if cell == GOAL
        @completed = true
        return completed
      end

      false
    end

    def column
      genome.current_position[0]
    end

    def row
      genome.current_position[1]
    end

    def generate_board
      JSON.parse(File.read(File.expand_path("board.json")))["board"]
      # JSON.parse(File.readboard.json"))["board"]
      # [
      #   ["#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#"],
      #   ["#", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "#"],
      #   ["#", " ", "#", "#", "#", "#", " ", "#", " ", "#", "#", "#", " ", " ", "#"],
      #   ["#", " ", "#", "#", "#", "#", " ", "#", " ", "#", "#", "#", "#", " ", "#"],
      #   ["#", " ", "#", "#", "#", "#", "#", "#", " ", "#", " ", "#", "#", " ", "#"],
      #   ["#", "I", "#", " ", "#", "#", " ", " ", " ", "#", " ", "#", "#", " ", "#"],
      #   ["#", " ", "#", " ", "#", "#", "#", "#", "#", "#", " ", " ", " ", " ", "#"],
      #   ["#", " ", "#", " ", "#", " ", " ", " ", " ", " ", " ", " ", "#", " ", "#"],
      #   ["#", " ", " ", " ", " ", " ", "#", "#", "#", "#", " ", " ", "#", "G", "#"],
      #   ["#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#"]
      # ]
    end

    GOAL = "G"
    PLAYER = "\e[34mP\e[0m"
    # PLAYER = "P"
    WALL = "#"
  end
end

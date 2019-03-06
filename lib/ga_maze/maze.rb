# frozen_string_literal: true

require "securerandom"
require "byebug"
require_relative "genome"

module GAMaze
  class Maze
    def initialize(
      # board: BOARD,
      # board: Array.new(ROWS) { Array.new(COLUMNS) },
      genome: Genome.new(goal: [8, 13]),
      completed: false,
      id: SecureRandom.uuid
    )
      @board = generate_board
      @genome = genome
      @completed = completed
      @id = id
      # byebug
    end

    def completed?
      completed
    end

    def run
      genome.genes.each do |gene|
        if gene == 1
          move_up
        elsif gene == 2
          move_down
        elsif gene == 3
          move_right
        elsif gene == 4
          move_left
        end
      end
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

    attr_accessor :board, :completed, :genome, :id

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
        return true
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
      [
        ["#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#"],
        ["#", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "#"],
        ["#", " ", "#", "#", "#", "#", " ", "#", " ", "#", "#", "#", " ", " ", "#"],
        ["#", " ", "#", "#", "#", "#", " ", "#", " ", "#", "#", "#", "#", " ", "#"],
        ["#", " ", "#", "#", "#", "#", "#", "#", " ", "#", " ", "#", "#", " ", "#"],
        ["#", "I", "#", " ", "#", "#", " ", " ", " ", "#", " ", "#", "#", " ", "#"],
        ["#", " ", "#", " ", "#", "#", "#", "#", "#", "#", " ", " ", " ", " ", "#"],
        ["#", " ", "#", " ", "#", " ", " ", " ", " ", " ", " ", " ", "#", " ", "#"],
        ["#", " ", " ", " ", " ", " ", "#", "#", "#", "#", " ", " ", "#", "G", "#"],
        ["#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#"]
      ]
    end

    ROWS = 10
    COLUMS = 15
    PLAYER = "P"
    WALL = "#"
    GOAL = "G"
    FLOOR = " "
  end
end

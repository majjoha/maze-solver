# frozen_string_literal: true

module MazeSolver
  class MazeNavigator
    def initialize(
      board: Board.new.board,
      chromosome: Chromosome.new,
      path: []
    )
      @board = board
      @chromosome = chromosome
      @path = path
    end

    def run
      chromosome.genes.reject(&:zero?).each do |gene|
        method(Chromosome::MOVES[gene]).call
      end
    end

    def step
      chromosome.positions.each do |position|
        column, row = position
        new_board = Board.new
        new_board.board[column][row] = PLAYER
        puts new_board.to_s
        gets
      end
    end

    private

    def move_up
      return if wall_or_goal?(board[column - 1][row])

      board[column][row] = " "
      board[column - 1][row] = PLAYER
      chromosome.update_position(column - 1, row)
      chromosome.add_move(:up)
    end

    def move_down
      return if wall_or_goal?(board[column + 1][row])

      board[column][row] = " "
      board[column + 1][row] = PLAYER
      chromosome.update_position(column + 1, row)
      chromosome.add_move(:down)
    end

    def move_left
      return if wall_or_goal?(board[column][row - 1])

      board[column][row] = " "
      board[column][row - 1] = PLAYER
      chromosome.update_position(column, row - 1)
      chromosome.add_move(:left)
    end

    def move_right
      return if wall_or_goal?(board[column][row + 1])

      board[column][row] = " "
      board[column][row + 1] = PLAYER
      chromosome.update_position(column, row + 1)
      chromosome.add_move(:right)
    end

    def wall
      last_step = chromosome.path.last
      chromosome.add_move(last_step) unless last_step.nil?
    end

    def wall?(cell)
      if cell == WALL
        @chromosome.penalties += 1
        return true
      end

      false
    end

    def goal?(cell)
      return true if cell == GOAL

      false
    end

    def wall_or_goal?(position)
      wall?(position) || goal?(position)
    end

    def column
      chromosome.current_position[0]
    end

    def row
      chromosome.current_position[1]
    end

    attr_accessor :board, :chromosome, :path

    GOAL = "G"
    PLAYER = "\e[35mP\e[0m"
    WALL = "#"
  end
end

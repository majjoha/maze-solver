# frozen_string_literal: true

module MazeSolver
  class MazeNavigator
    def initialize(
      board: Board.new.board,
      genome: Chromosome.new,
      path: []
    )
      @board = board
      @genome = genome
      @path = path
    end

    def run
      genome.genes.reject(&:zero?).each {|gene| send(Chromosome::MOVES[gene]) }
    end

    def step
      genome.positions.each do |position|
        column, row = position
        new_board = Board.new
        new_board.board[column][row] = PLAYER
        puts new_board.to_s
        gets
      end
    end

    private

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

    def wall
      last_step = genome.path.last
      genome.add_move(last_step) unless last_step.nil?
    end

    def wall?(cell)
      if cell == WALL
        @genome.penalties += 1
        return true
      end

      false
    end

    def goal?(cell)
      return true if cell == GOAL

      false
    end

    def column
      genome.current_position[0]
    end

    def row
      genome.current_position[1]
    end

    attr_accessor :board, :genome, :path

    GOAL = "G"
    PLAYER = "\e[35mP\e[0m"
    WALL = "#"
  end
end

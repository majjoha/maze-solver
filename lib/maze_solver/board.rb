# frozen_string_literal: true

require "json"

module MazeSolver
  class Board
    def initialize(
      board: JSON.parse(File.read(File.expand_path("board.json")))["board"]
    )
      @board = board
    end

    def to_s
      board.map {|row| row.join(" ") }
    end

    def self.goal
      new.find_index("G")
    end

    def self.start
      new.find_index("S")
    end

    def find_index(character)
      board.each_index do |column|
        row = board[column].index(character)
        return [column, row] if row
      end
    end

    attr_accessor :board
  end
end

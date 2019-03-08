# frozen_string_literal: true

require "json"

module GAMaze
  class Board
    def initialize(
      board: JSON.parse(File.read(File.expand_path("board.json")))["board"]
    )
      @board = board
    end

    def to_s
      board.map {|row| row.join(" ") }
    end

    attr_accessor :board
  end
end

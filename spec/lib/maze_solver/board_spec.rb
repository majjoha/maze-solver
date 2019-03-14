# frozen_string_literal: true

require_relative "../../spec_helper"

describe MazeSolver::Board do
  describe ".goal" do
    it "finds the goal position" do
      expect(described_class.goal).to eq([8, 13])
    end
  end

  describe ".start" do
    it "finds the start position" do
      expect(described_class.start).to eq([8, 1])
    end
  end
end

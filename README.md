# Maze Solver
[![Build Status](https://travis-ci.org/majjoha/maze-solver.svg)](https://travis-ci.org/majjoha/maze-solver)

Maze Solver is a demonstration of how genetic algorithms can be utilized to move
an agent from a given position to a goal in a maze environment. It reads a maze
located in the
[`board.json`](https://github.com/majjoha/maze-solver/blob/master/board.json)
file where `#`, `S`, and `G` indicate a wall, start position, and goal,
respectively.

It is written as a part of a mandatory assignment in the course [Artificial Life
& Evolutionary Robotics: Theory, Methods and
Art](https://mit.itu.dk/ucs/cb_www/course.sml?course_id=2708762) at the [IT
University of Copenhagen](https://en.itu.dk).

## Requirements
* Ruby (2.6.0) or newer.

## Installation
Simply run `bundle` to install dependencies.

## Usage
Run the algorithm and step through the maze by pressing enter:

```
./bin/maze_solver
```

Run the test suite:

```
rspec
```

## License
See [LICENSE](https://github.com/majjoha/maze-solver/blob/master/LICENSE).

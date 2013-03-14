defrecord Board, towers: [], players: [], max_x: 10, max_y: 10

defmodule BoardBehavior do
  def initialize() do
    board = Board.new
    board = board.towers([Tower.new(x: 5, y: 5, range: 3)])
    board = board.players([Player.new(x: 0, y: 5, hp: 10)])
    board
  end

  def run(board) do
    board = tick(board)
    show(board)
    if !empty(board), do: run(board)
  end

  def show(board) do
    IO.puts inspect(board)
  end

  def empty(board) do
    board.players == []
  end

  def tick(board) do
    board = board.players(Enum.map board.players, fn(x) -> PlayerBehavior.tick(x, board) end)
    board = remove_out_of_bounds(board)
    board.towers(Enum.map board.towers, fn(x) -> TowerBehavior.tick(x, board) end)
  end

  def remove_out_of_bounds(board) do
    players = lc player inlist board.players, player.x <= board.max_x && player.y <= board.max_y, do: player
    board.players(players)
  end

end

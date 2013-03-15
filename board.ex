defrecord Board, towers: [], players: [], max_x: 10, max_y: 10

defmodule BoardBehavior do

  def initialize() do
    board = Board.new
    #board = board.towers([Tower.new(x: 4, y: 5, range: 4), Tower.new(x: 6, y: 5, range: 4)])
    board = board.towers([Tower.new(x: 4, y: 5, range: 4, id: 1)])
    board = board.players([Player.new(x: 0, y: 3, hp: 10, name: "Julia"), Player.new(x: 0, y: 5, hp: 10, name: "Anders"), Player.new(x: 0, y: 6, hp: 10, name: "Kelly")])
    #:wx.new()
    board
  end

  def run(board) do
    board = tick(board)
    show(board)
    if !empty(board), do: run(board)
  end

  def show(board) do
    #IO.puts inspect(board)
    :io.format("~w~n", [7])
  end

  def empty(board) do
    board.players == []
  end

  def tick(board) do
    board = board.players(Enum.map board.players, fn(x) -> PlayerBehavior.tick(x, board) end)
    IO.puts "Players advanced"
    board = remove_out_of_bounds(board)
    board = tick_towers(board, board.towers)
  end

  def tick_towers(board, [h | t]) do
    board = TowerBehavior.tick(h, board)
    tick_towers(board, t)
  end

  def tick_towers(board, []) do
    board
  end

  def remove_out_of_bounds(board) do
    escaped = Enum.filter board.players, fn(player) -> player.x > board.max_x || player.y > board.max_y end
    

    if Enum.count(escaped) > 0, do: IO.puts "#{Enum.map_join escaped, " and ", fn(player) -> player.name end} escaped"
    
    board.players(Enum.filter board.players, fn(player) -> player.x <= board.max_x && player.y <= board.max_y end)
  end

end

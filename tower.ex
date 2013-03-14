defrecord Tower, x: nil, y: nil, range: 1

defmodule TowerBehavior do
  def tick(tower, board) do
    # if in range shoot it
    target = closest_in_range(tower, board.players)
    
    if target do
      IO.puts "Attacking #{inspect(target)}"
      new_player = PlayerBehavior.attack(target, 2)
      board = board.players(List.concat(List.delete(board.players, target), [new_player]))
    end

#need to return board
    tower
  end

  def closest_in_range(tower, []) do
  end
 
  def closest_in_range(tower, [h | t]) do
    closest_in_range(tower, t, range(h, tower), h) 
  end

  def closest_in_range(tower, [h | t], current_min_val, current_winner) do
    test_range = range(h, tower)
    if current_min_val > test_range do
      closest_in_range(tower, t, test_range, h)
    else
      closest_in_range(tower, t, current_min_val, current_winner)
    end
  end

  def closest_in_range(tower, [], current_min_val, current_winner) do
    current_winner
  end

  def range(player, tower) do
    :math.sqrt(:math.pow(player.x - tower.x, 2) + :math.pow(player.y - tower.y, 2))
  end
end

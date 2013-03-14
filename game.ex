Code.require_file "../player.ex", __FILE__
Code.require_file "../tower.ex", __FILE__
Code.require_file "../board.ex", __FILE__

b = BoardBehavior.initialize
BoardBehavior.run(b)

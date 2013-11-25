module Tennis
  class Game
    attr_accessor :player1, :player2

    def initialize
      @player1 = Player.new
      @player2 = Player.new

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    # Records a win for a ball in a game.
    #
    # winner - The Integer (1 or 2) representing the winning player.
    #
    # Returns the score of the winning player. 
    def wins_ball(winner)
      if winner == 1
        winning_player = @player1
      elsif winner == 2
        winning_player = @player2
      end
      winning_player.record_won_ball!
    end

    # Returns the game score
    def game_score
      # Game win (first to 4 point to win by 2)
      if (player1.points >= 4 || player2.points >= 4) && (player1.points - player2.points).abs >= 2
        if player1.points > player2.points
          return "game, player1"
        else
          return "game, player2"
        end
      # Deuce game
      elsif (player1.points >= 3 && player2.points >= 3)
        if player1.points == player2.points
          return "deuce"
        elsif player1.points - player2.points == 1
          return "advantage, player1"
        elsif player2.points - player1.points == 1
          return "advantage, player2"
        end
      # Score if not in deuce game
      else
        return "#{player1.score} - #{player2.score}"
      end
    end
  end

  class Player
    attr_accessor :points, :opponent

    def initialize
      @points = 0
    end

    # Increments the score by 1.
    #
    # Returns the integer new score.
    def record_won_ball!
      @points += 1
    end

    # Returns the String score for the player.
    def score
      return 'love' if @points == 0
      return 'fifteen' if @points == 1
      return 'thirty' if @points == 2
      return 'forty' if @points == 3
    end
  end
end
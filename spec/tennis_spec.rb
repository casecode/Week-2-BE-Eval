require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../tennis'

describe Tennis::Game do
  let(:game) { Tennis::Game.new }

  describe '.initialize' do
    it 'creates two players' do
      expect(game.player1).to be_a(Tennis::Player)
      expect(game.player2).to be_a(Tennis::Player)
    end

    it 'sets the opponent for each player' do
      expect(game.player1.opponent).to eq(game.player2)
      expect(game.player2.opponent).to eq(game.player1)
    end
  end

  describe '#wins_ball' do
    it 'increments the points of the winning player' do
      game.wins_ball(1)

      expect(game.player1.points).to eq(1)
    end
  end

  describe '#game_score' do
    context 'when game won not in deuce game' do
      it "returns game won and winner" do
        game.player1.points = 4
        game.player2.points = 2

        expect(game.game_score).to eq('game, player1')
      end
    end

    context 'when game won in deuce game' do
      it "returns game won and winner" do
        game.player2.points = 9
        game.player1.points = 7

        expect(game.game_score).to eq('game, player2')
      end
    end

    context 'when points of both players equal and greater than 2' do
      it "returns deuce score" do
        game.player1.points = 3
        game.player2.points = 3

        expect(game.game_score).to eq('deuce')
      end
    end

    context 'when a player wins one point at deuce' do
      it "returns advantage score" do
        game.player1.points = 6
        game.player2.points = 5

        expect(game.game_score).to eq('advantage, player1')
      end
    end

    context 'when game not won and not in deuce game' do
      it "returns score" do
        game.player1.points = 3
        game.player2.points = 0

        expect(game.game_score).to eq('forty - love')
      end
    end
  end
end

describe Tennis::Player do
  let(:player) do
    player = Tennis::Player.new
    player.opponent = Tennis::Player.new

    return player
  end

  describe '.initialize' do
    it 'sets the points to 0' do
      expect(player.points).to eq(0)
    end 
  end

  describe '#record_won_ball!' do
    it 'increments the points' do
      player.record_won_ball!

      expect(player.points).to eq(1)
    end
  end

  describe '#score' do
    context 'when points is 0' do
      it 'returns love' do
        player.points = 0

        expect(player.score).to eq('love')
      end
    end
    
    context 'when points is 1' do
      it 'returns fifteen' do
        player.points = 1

        expect(player.score).to eq('fifteen')
      end 
    end
    
    context 'when points is 2' do
      it 'returns thirty' do
        player.points = 2

        expect(player.score).to eq('thirty')
      end 
    end
    
    context 'when points is 3' do
      it 'returns forty' do
        player.points = 3

        expect(player.score).to eq('forty')
      end 
    end
  end
end
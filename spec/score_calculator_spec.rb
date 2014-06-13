require 'rails_helper'	
require './lib/score_calculator.rb'

describe ScoreCalculator do
  describe "team_score_for_match" do
    
    before(:each) do
      ranks = {1 => 'first', 2 => 'second', 3 => 'third', 4 => 'forth'}
      @r1 = 1 + rand(4)
      @r2 = 1 + rand(4)
      @team_a = Team.send("#{ranks[@r1]}_rank").sample
      @team_b = Team.send("#{ranks[@r2]}_rank").sample 
      @team_b = Team.send("#{ranks[@r2]}_rank").sample until @team_a != @team_b
    
    end

    it "returns correct score for group bets" do
      @bet = FactoryGirl.create(:group_bet, team_id: @team_a.id)
      @match = FactoryGirl.build(:match, team_a: @team_a, team_b: @team_b)

      [[:win, 1, 0], [:draw, 1, 1], [:lost, 0, 1]].each do |res, t_a_score, t_b_score|
        @match.score = { team_a_score: t_a_score, team_b_score: t_b_score }
        expected_score = ScoreCalculator::SCORES_BY_RANK_VS_RANK[@r1][@r2][res]

        expect( ScoreCalculator.send(:bet_score_for_match, @bet, @match) ).to eq(expected_score)
      end
    end

    it "returns correct score for scores the most bet" do
      [[:scores_the_most_bet, true], [:gets_the_most_bet, false]].each do |bet, scoring_team|
        @bet = FactoryGirl.create(bet, team_id: @team_a.id)
        @match = FactoryGirl.build(:match, team_a: @team_a, team_b: @team_b)
        t_a_score = rand(10)
        t_b_score = rand(10)
        @match.score = {team_a_score: t_a_score, team_b_score: t_b_score}
        expected_score = (scoring_team ? t_a_score : t_b_score) * ScoreCalculator::SCORE_PER_GOAL
        expect( ScoreCalculator.send(:bet_score_for_match, @bet, @match) ).to eq(expected_score)
      end
    end
  end
end
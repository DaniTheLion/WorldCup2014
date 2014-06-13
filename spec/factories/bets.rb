FactoryGirl.define do
  factory :bet do

    factory :group_bet do
      type_of_bet { bet_type_for_team(team_id) }
    end

    factory :scores_the_most_bet do
      type_of_bet :scores_the_most
    end

    factory :gets_the_most_bet do
      type_of_bet :gets_the_most
    end

  end
end

def bet_type_for_team(team_id)
  case Team.find(team_id).rank
  when 1
    'team_a'
  when 2
    'team_b'
  when 3
    'team_c'
  when 4
    'team_d'
  end  
end
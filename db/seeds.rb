# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Team.create([
	{name: 'Algeria', code: 'alg'},
	{name: 'Cameroon', code: 'cmr'},
	{name: 'Côte d\'Ivoire', code: 'civ'},
	{name: 'Ghana', code: 'gha'},
	{name: 'Nigeria', code: 'nga'},
	{name: 'Australia', code: 'aus'},
	{name: 'Iran', code: 'irn'},
	{name: 'Japan', code: 'jpn'},
	{name: 'Korea Republic', code: 'kor'},
	{name: 'Belgium', code: 'bel'},
	{name: 'Boasnia and Herzegovina', code: 'bih'},
	{name: 'Croatia', code: 'cro'},
	{name: 'England', code: 'eng'},
	{name: 'France', code: 'fra'},
	{name: 'Germany', code: 'ger'},
	{name: 'Greece', code: 'gre'},
	{name: 'Italy', code: 'ita'},
	{name: 'Netherlands', code: 'ned'},
	{name: 'Portugal', code: 'por'},
	{name: 'Russia', code: 'rus'},
	{name: 'Spain', code: 'eps'},
	{name: 'Switzerland', code: 'sui'},
	{name: 'Costa Rica', code: 'crc'},
	{name: 'Honhuras', code: 'hon'},
	{name: 'Mexico', code: 'mex'},
	{name: 'USA', code: 'usa'},
	{name: 'Argentina', code: 'arg'},
	{name: 'Brazil', code: 'bra'},
	{name: 'Chile', code: 'chi'},
	{name: 'Colombia', code: 'col'},
	{name: 'Ecuador', code: 'ecu'},
	{name: 'Uruguay', code: 'uru'}	])


teams = Hash[ Team.all.collect{|t| [t.name,t]}]



matches = [
['Brazil','Croatia',DateTime.new(2014,6,12,23)],
['Mexico','Cameroon', DateTime.new(2014, 6, 13, 19)],
['Spain', 'Netherlands', DateTime.new(2014, 6, 13, 22)],
['Chile', 'Australia', DateTime.new(2014, 6, 14, 1)],


['Colombia', 'Greece', DateTime.new(2014, 6, 14, 19)],
['Uruguay', 'Costa Rica', DateTime.new(2014, 6, 14, 22)],

['England', 'Italy', DateTime.new(2014, 6, 15, 01)],
['Côte d\'Ivoire', 'Japan', DateTime.new(2014, 6, 15, 04)],


['Switzerland', 'Ecuador', DateTime.new(2014, 6, 15, 19)],
['France', 'Honhuras', DateTime.new(2014, 6, 15, 22)],

['Argentina', 'Boasnia and Herzegovina', DateTime.new(2014, 6, 16, 01)],

['Germany', 'Portugal', DateTime.new(2014, 6, 16, 19)],
['Iran', 'Nigeria', DateTime.new(2014, 6, 16, 22)],

['Ghana', 'USA', DateTime.new(2014, 6, 17, 01)],
['Belgium', 'Algeria', DateTime.new(2014, 6, 17, 19)],
['Brazil', 'Mexico', DateTime.new(2014, 6, 17, 22)],

['Russia', 'Korea Republic', DateTime.new(2014, 6, 18, 01)],
['Australia', 'Netherlands', DateTime.new(2014, 6, 18, 19)],
['Spain', 'Chile', DateTime.new(2014, 6, 18, 22)],


['Cameroon', 'Croatia', DateTime.new(2014, 6, 19, 01)],
['Colombia', 'Côte d\'Ivoire', DateTime.new(2014, 6, 19, 19)],
['Uruguay', 'England', DateTime.new(2014, 6, 19, 22)],

['Japan', 'Greece', DateTime.new(2014, 6, 20, 01)],
['Italy', 'Costa Rica', DateTime.new(2014, 6, 20, 19)],
['Switzerland', 'France', DateTime.new(2014, 6, 20, 22)],

['Honhuras', 'Ecuador', DateTime.new(2014, 6, 21, 01)],
['Argentina', 'Iran', DateTime.new(2014, 6, 21, 19)],
['Germany', 'Ghana', DateTime.new(2014, 6, 21, 22)],

['Nigeria', 'Boasnia and Herzegovina', DateTime.new(2014, 6, 22, 01)],
['Belgium', 'Russia', DateTime.new(2014, 6, 22, 19)],
['Korea Republic', 'Algeria', DateTime.new(2014, 6, 22, 22)],

['USA', 'Portugal', DateTime.new(2014, 6, 23, 01)],

['Netherlands', 'Chile', DateTime.new(2014, 6, 23, 19)],
['Australia', 'Spain', DateTime.new(2014, 6, 23, 19)],
['Cameroon', 'Brazil', DateTime.new(2014, 6, 23, 23)],
['Croatia', 'Mexico', DateTime.new(2014, 6, 23, 23)],

['Italy', 'Uruguay', DateTime.new(2014, 6, 24, 19)],
['Costa Rica', 'England', DateTime.new(2014, 6, 24, 19)],
['Japan', 'Colombia', DateTime.new(2014, 6, 24, 23)],
['Greece', 'Côte d\'Ivoire', DateTime.new(2014, 6, 24, 23)],

['Nigeria', 'Argentina', DateTime.new(2014, 6, 25, 19)],
['Boasnia and Herzegovina', 'Iran', DateTime.new(2014, 6, 25, 19)],
['Honhuras', 'Switzerland', DateTime.new(2014, 6, 25, 23)],
['Ecuador', 'France', DateTime.new(2014, 6, 25, 23)],

['Portugal', 'Ghana', DateTime.new(2014, 6, 26, 19)],
['USA', 'Germany', DateTime.new(2014, 6, 26, 19)],
['Korea Republic', 'Belgium', DateTime.new(2014, 6, 26, 23)],
['Algeria', 'Russia', DateTime.new(2014, 6, 26, 23)]
]

matches.each do |a,b,time|
	Match.create!(team_a: teams[a], team_b: teams[b], starting_time: time, round: :group_round)
end
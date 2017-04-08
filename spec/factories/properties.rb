FactoryGirl.define do
  factory :property do
     title             {  FFaker::Lorem.sentence }
     accommodates      2
     bathrooms         3
     number_of_rooms   3
     furnished         false
     price             { rand() * 100 }
     description       {  FFaker::Lorem.sentence(1) }
     published false
     user
  end
end
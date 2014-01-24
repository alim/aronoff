# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :strain_name do |n|
    "GBS - #{n}"
  end

  sequence :experiment_id do |n|
    "Experiment - #{n}"
  end

  sequence :notes do |n|
    "Experimental notes section for testing - #{n}"
  end

  # expects user as a parameter
  factory :macrophage do
    strain_name { generate(:strain_name) }
    experiment_id { generate(:experiment_id) }
    macrophage_type { rand(1..5) }
    treatment { rand(1..3) }
    dose { rand(1..4) }
    data { rand(1..10000) }
    data_type { rand(1..2) }
    notes { generate(:notes) }
  end

  # expects both user and strain_name
  factory :bacteria_macrophage, class: Macrophage do
    experiment_id { generate(:experiment_id) }
    macrophage_type { rand(1..5) }
    treatment { rand(1..3) }
    dose { rand(1..4) }
    data { rand(1..10000) }
    data_type { rand(1..2) }
    notes { generate(:notes) }
  end  
end

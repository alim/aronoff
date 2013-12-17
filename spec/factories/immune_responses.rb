# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :immune_response do
    experiment_id  { generate(:experiment_id) }
    strain_name  { generate(:strain_name) }
    cell_type { rand(1..7) }
    model { rand(1..6) }
    compartment { rand(1..3) }
    time_point { rand(1..100) }
    moi { rand(1..100) }
    strain_status { rand(1..3) }
    treatment { rand(1..5) }
    dose { rand(1..10000) }
    result { rand(1..10000) }
    cyto_chemo_kine { rand(1..9) }
    units { rand(1..4) }
    notes { generate(:notes) }
  end
end

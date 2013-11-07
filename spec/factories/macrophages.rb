# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :macrophage do
    strain_name ""
    experiment_id ""
    macrophage_type ""
    treatment ""
    dose ""
    data ""
    data_type ""
  end
end

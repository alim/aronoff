require 'spec_helper'

describe "immune_responses/show" do
  before(:each) do
    @immune_response = assign(:immune_response, stub_model(ImmuneResponse,
      :experiment_id => "",
      :strain_name => "",
      :cell_type => "",
      :model => "",
      :compartment => "",
      :time_point => "",
      :moi => "",
      :strain_status => "",
      :treatment => "",
      :units => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end

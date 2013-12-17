require 'spec_helper'

describe "immune_responses/edit" do
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

  it "renders the edit immune_response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", immune_response_path(@immune_response), "post" do
      assert_select "input#immune_response_experiment_id[name=?]", "immune_response[experiment_id]"
      assert_select "input#immune_response_strain_name[name=?]", "immune_response[strain_name]"
      assert_select "input#immune_response_cell_type[name=?]", "immune_response[cell_type]"
      assert_select "input#immune_response_model[name=?]", "immune_response[model]"
      assert_select "input#immune_response_compartment[name=?]", "immune_response[compartment]"
      assert_select "input#immune_response_time_point[name=?]", "immune_response[time_point]"
      assert_select "input#immune_response_moi[name=?]", "immune_response[moi]"
      assert_select "input#immune_response_strain_status[name=?]", "immune_response[strain_status]"
      assert_select "input#immune_response_treatment[name=?]", "immune_response[treatment]"
      assert_select "input#immune_response_units[name=?]", "immune_response[units]"
    end
  end
end

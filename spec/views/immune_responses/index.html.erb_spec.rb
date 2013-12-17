require 'spec_helper'

describe "immune_responses/index" do
  before(:each) do
    assign(:immune_responses, [
      stub_model(ImmuneResponse,
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
      ),
      stub_model(ImmuneResponse,
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
      )
    ])
  end

  it "renders a list of immune_responses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

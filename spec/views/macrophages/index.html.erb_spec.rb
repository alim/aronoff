require 'spec_helper'

describe "macrophages/index" do
  before(:each) do
    assign(:macrophages, [
      stub_model(Macrophage,
        :strain_name => "",
        :experiment_id => "",
        :macrophage_type => "",
        :treatment => "",
        :dose => "",
        :data => "",
        :data_type => ""
      ),
      stub_model(Macrophage,
        :strain_name => "",
        :experiment_id => "",
        :macrophage_type => "",
        :treatment => "",
        :dose => "",
        :data => "",
        :data_type => ""
      )
    ])
  end

  it "renders a list of macrophages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

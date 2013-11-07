require 'spec_helper'

describe "macrophages/show" do
  before(:each) do
    @macrophage = assign(:macrophage, stub_model(Macrophage,
      :strain_name => "",
      :experiment_id => "",
      :macrophage_type => "",
      :treatment => "",
      :dose => "",
      :data => "",
      :data_type => ""
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
  end
end

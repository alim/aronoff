require 'spec_helper'

describe "macrophages/new" do
  before(:each) do
    assign(:macrophage, stub_model(Macrophage,
      :strain_name => "",
      :experiment_id => "",
      :macrophage_type => "",
      :treatment => "",
      :dose => "",
      :data => "",
      :data_type => ""
    ).as_new_record)
  end

  it "renders new macrophage form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", macrophages_path, "post" do
      assert_select "input#macrophage_strain_name[name=?]", "macrophage[strain_name]"
      assert_select "input#macrophage_experiment_id[name=?]", "macrophage[experiment_id]"
      assert_select "input#macrophage_macrophage_type[name=?]", "macrophage[macrophage_type]"
      assert_select "input#macrophage_treatment[name=?]", "macrophage[treatment]"
      assert_select "input#macrophage_dose[name=?]", "macrophage[dose]"
      assert_select "input#macrophage_data[name=?]", "macrophage[data]"
      assert_select "input#macrophage_data_type[name=?]", "macrophage[data_type]"
    end
  end
end

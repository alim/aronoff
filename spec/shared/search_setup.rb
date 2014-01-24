########################################################################
# Provide shared macros for testing user accounts 
########################################################################
shared_context 'search_setup' do
  include_context 'user_setup'

  # Search by strain_name setup ----------------------------------------
	let(:strain_search_data) {
    signin_customer

		@strain_name = 'GB1007'
    @record_count = 20

    @record_count.times.each { FactoryGirl.create(:bacteria_immune_response, 
      user: @signed_in_user, strain_name: @strain_name) }
    @iresponses = ImmuneResponse.all
    @iresponses.count.should eq(@record_count)

    # Calculate how many records we should find
    @ir_count = ImmuneResponse.by_strain(@strain_name).count
    @ir_count.should > 0
    @ir_count = ApplicationController::PAGE_COUNT if @ir_count > ApplicationController::PAGE_COUNT

    @record_count.times.each { FactoryGirl.create(:bacteria_macrophage, 
      user: @signed_in_user, strain_name: @strain_name) }
    @macrophages = Macrophage.all
    @macrophages.count.should eq(@record_count)

    # Calculate how many records we should find
    @mac_count = Macrophage.by_strain(@strain_name).count
    @mac_count.should > 0
    @mac_count = ApplicationController::PAGE_COUNT if @mac_count > ApplicationController::PAGE_COUNT
	}
		
end

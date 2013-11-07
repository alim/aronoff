require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe MacrophagesController do

  # This should return the minimal set of attributes required to create a valid
  # Macrophage. As you add validations to Macrophage, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "strain_name" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MacrophagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all macrophages as @macrophages" do
      macrophage = Macrophage.create! valid_attributes
      get :index, {}, valid_session
      assigns(:macrophages).should eq([macrophage])
    end
  end

  describe "GET show" do
    it "assigns the requested macrophage as @macrophage" do
      macrophage = Macrophage.create! valid_attributes
      get :show, {:id => macrophage.to_param}, valid_session
      assigns(:macrophage).should eq(macrophage)
    end
  end

  describe "GET new" do
    it "assigns a new macrophage as @macrophage" do
      get :new, {}, valid_session
      assigns(:macrophage).should be_a_new(Macrophage)
    end
  end

  describe "GET edit" do
    it "assigns the requested macrophage as @macrophage" do
      macrophage = Macrophage.create! valid_attributes
      get :edit, {:id => macrophage.to_param}, valid_session
      assigns(:macrophage).should eq(macrophage)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Macrophage" do
        expect {
          post :create, {:macrophage => valid_attributes}, valid_session
        }.to change(Macrophage, :count).by(1)
      end

      it "assigns a newly created macrophage as @macrophage" do
        post :create, {:macrophage => valid_attributes}, valid_session
        assigns(:macrophage).should be_a(Macrophage)
        assigns(:macrophage).should be_persisted
      end

      it "redirects to the created macrophage" do
        post :create, {:macrophage => valid_attributes}, valid_session
        response.should redirect_to(Macrophage.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved macrophage as @macrophage" do
        # Trigger the behavior that occurs when invalid params are submitted
        Macrophage.any_instance.stub(:save).and_return(false)
        post :create, {:macrophage => { "strain_name" => "invalid value" }}, valid_session
        assigns(:macrophage).should be_a_new(Macrophage)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Macrophage.any_instance.stub(:save).and_return(false)
        post :create, {:macrophage => { "strain_name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested macrophage" do
        macrophage = Macrophage.create! valid_attributes
        # Assuming there are no other macrophages in the database, this
        # specifies that the Macrophage created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Macrophage.any_instance.should_receive(:update).with({ "strain_name" => "" })
        put :update, {:id => macrophage.to_param, :macrophage => { "strain_name" => "" }}, valid_session
      end

      it "assigns the requested macrophage as @macrophage" do
        macrophage = Macrophage.create! valid_attributes
        put :update, {:id => macrophage.to_param, :macrophage => valid_attributes}, valid_session
        assigns(:macrophage).should eq(macrophage)
      end

      it "redirects to the macrophage" do
        macrophage = Macrophage.create! valid_attributes
        put :update, {:id => macrophage.to_param, :macrophage => valid_attributes}, valid_session
        response.should redirect_to(macrophage)
      end
    end

    describe "with invalid params" do
      it "assigns the macrophage as @macrophage" do
        macrophage = Macrophage.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Macrophage.any_instance.stub(:save).and_return(false)
        put :update, {:id => macrophage.to_param, :macrophage => { "strain_name" => "invalid value" }}, valid_session
        assigns(:macrophage).should eq(macrophage)
      end

      it "re-renders the 'edit' template" do
        macrophage = Macrophage.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Macrophage.any_instance.stub(:save).and_return(false)
        put :update, {:id => macrophage.to_param, :macrophage => { "strain_name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested macrophage" do
      macrophage = Macrophage.create! valid_attributes
      expect {
        delete :destroy, {:id => macrophage.to_param}, valid_session
      }.to change(Macrophage, :count).by(-1)
    end

    it "redirects to the macrophages list" do
      macrophage = Macrophage.create! valid_attributes
      delete :destroy, {:id => macrophage.to_param}, valid_session
      response.should redirect_to(macrophages_url)
    end
  end

end

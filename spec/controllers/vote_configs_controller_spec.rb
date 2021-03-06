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

describe VoteConfigsController do
  login_admin
  render_views
  describe "GET index" do
    before(:each) do
      @vote_config ||= Factory(:vote_config)
    end

    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    before(:each) do
      @vote_config ||= Factory(:vote_config)
    end

    it "should render 'show'" do
      get :show, :id => @vote_config
      response.should render_template('show')
    end
  end

  describe "GET new" do
    it "should be sucesss" do
      get :new
      response.should be_success
    end
    it "should render template 'new'" do
      get :new
      response.should render_template('new')
    end
  end

  describe "POST create" do
    before(:each) do
      @votable_item = Factory(:votable_item)
    end
    describe "with valid params" do
      it "the vote_config should success create" do
        lambda do
          post :create,:vote_config => {:name => "vote config",:mth => "201408",:expire_date => '2014-08-31'}
        end.should change(VoteConfig,:count).by(1)
      end

      it "redirects to the created vote config" do
        post :create,:vote_config => {:name => "vote config",:mth => "201408",:expire_date => '2014-08-31'}
        response.should redirect_to(assigns[:vote_config])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :vote_config => {}
        response.should render_template('new')
      end
    end
  end


  describe "DELETE destroy" do
    before(:each) do
      @vote_config ||= Factory(:vote_config)
    end

    it "destroys the requested load_list" do
      lambda do
        delete :destroy ,:id => @vote_config
      end.should change(VoteConfig,:count).by(-1)
    end

    it "redirects to the load_lists list" do
      delete :destroy, :id => @vote_config
      response.should redirect_to(vote_configs_url)
    end
  end

end

require 'test_helper'

class SurveydataControllerTest < ActionController::TestCase
  setup do
    @surveydatum = surveydata(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveydata)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create surveydatum" do
    assert_difference('Surveydatum.count') do
      post :create, surveydatum: { email: @surveydatum.email, surveyresponse: @surveydatum.surveyresponse }
    end

    assert_redirected_to surveydatum_path(assigns(:surveydatum))
  end

  test "should show surveydatum" do
    get :show, id: @surveydatum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @surveydatum
    assert_response :success
  end

  test "should update surveydatum" do
    patch :update, id: @surveydatum, surveydatum: { email: @surveydatum.email, surveyresponse: @surveydatum.surveyresponse }
    assert_redirected_to surveydatum_path(assigns(:surveydatum))
  end

  test "should destroy surveydatum" do
    assert_difference('Surveydatum.count', -1) do
      delete :destroy, id: @surveydatum
    end

    assert_redirected_to surveydata_path
  end
end

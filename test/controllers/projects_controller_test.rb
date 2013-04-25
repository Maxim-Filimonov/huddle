require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @project = projects(:one)
  end
  setup :login_as_one

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create project' do
    assert_difference('Project.count') do
      post :create, project: { name: @project.name }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test 'should show project' do
    get :show, id: @project
    assert_response :success
  end
  test 'project timeline index should be sorted correctly' do
    set_current_project(:huddle)
    get :show, :id => projects(:huddle).id
    expected_keys = assigns(:reports).keys.sort.map {|d| d.to_s(:db)}
    assert_equal(%w(2009-01-06 2009-01-07), expected_keys)
    assert_equal(
        [status_reports(:one_tue).id, status_reports(:two_tue).id],
        assigns(:reports)[Date.parse('2009-01-06')].map(&:id)
    )
  end
  test 'show should display project timeline' do
    set_current_project(:huddle)
    get :show, :id => projects(:huddle).id
    assert_select 'div[id *= day]', count: 2
    assert_select 'div#2009-01-06_day' do
      assert_select 'div[id *= report]', count: 2
      assert_select 'div#?', dom_id(status_reports(:one_tue))
      assert_select 'div#?', dom_id(status_reports(:two_tue))
    end
    assert_select 'div#2009-01-07_day' do
      assert_select 'div[id *= report]', count: 2
      assert_select 'div#?', dom_id(status_reports(:one_wed))
      assert_select 'div#?', dom_id(status_reports(:two_wed))
    end
  end

  test 'should get edit' do
    get :edit, id: @project
    assert_response :success
  end

  test 'should update project' do
    patch :update, id: @project, project: { name: @project.name }
    assert_redirected_to project_path(assigns(:project))
  end

  test 'should destroy project' do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end

require 'test_helper'

class StatusReportsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @status_report = status_reports(:one)
  end
  setup :login_as_one

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_reports)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'creation of status report with data' do
    set_current_project(:one)
    assert_difference('StatusReport.count') do
      post :create, status_report: {today: 't', yesterday: 'y'}
    end
    actual = assigns(:status_report)
    assert_equal(projects(:one).id, actual.project.id)
    assert_equal(users(:one).id, actual.user.id)
    assert_equal(Date.today, actual.status_date.to_s(:db))

    assert_redirected_to status_report_path(assigns(:status_report))
  end
  test 'user should not be allowed create status report for different user' do
    evil_user = User.create!(email: 'bla@bla.com', password: 'banana', password_confirmation: 'banana')
    set_current_project(:one)
    assert_no_difference('StatusReport.count') do
      post :create, status_report: {
          user_id: evil_user.id,
          yesterday: 'I did stuff',
          today: 'I\'ll do stuff'
      }
    end
    assert_nil session[:user_id]
    assert_redirected_to(new_user_session_path)
  end

  test 'should show status_report' do
    get :show, id: @status_report
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @status_report
    assert_response :success
  end

  test 'should update status_report' do
    patch :update, id: @status_report, status_report: {project_id: @status_report.project_id, status_date: @status_report.status_date, today: @status_report.today, user_id: @status_report.user_id, yesterday: @status_report.yesterday}
    assert_redirected_to status_report_path(assigns(:status_report))
  end

  test 'should destroy status_report' do
    assert_difference('StatusReport.count', -1) do
      delete :destroy, id: @status_report
    end

    assert_redirected_to status_reports_path
  end
end

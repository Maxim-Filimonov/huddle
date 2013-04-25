require 'test_helper'

class StatusReportTest < ActiveSupport::TestCase
  test 'saving a status report saves the status date' do
    actual = StatusReport.new today: 't', yesterday: 'y'
    actual.save
    assert_equal(Date.today.to_s, actual.status_date.to_s)
  end
  test "saving a status report that has a date doesn't override it" do
    expected_date = 2.days.ago.to_date
    actual = StatusReport.new :status_date => expected_date, today: 't', yesterday: 'y'
    actual.save
    actual.reload
    assert_equal(expected_date.to_s, actual.status_date.to_s)
  end
  test 'a report with both blank statuses blank is not valid' do
    actual = StatusReport.new today: '', yesterday: ''
    assert !actual.valid?
  end
  test 'a report with yesterday blank is valid' do
    actual = StatusReport.new today: 'toda', yesterday: ''
    assert actual.valid?
  end
  test 'a report with today blank is valid' do
    actual = StatusReport.new today: '', yesterday: 'yesterday'
    assert actual.valid?
  end
  test 'by user name should sort as expected' do
    reports = StatusReport.by_user_name
    p reports.map {|r| r.user }.inspect
    expected = reports.map { |r| r.user.email }
    assert_equal %w(one@one.com one@one.com two@two.com two@two.com),
                 expected
  end
end

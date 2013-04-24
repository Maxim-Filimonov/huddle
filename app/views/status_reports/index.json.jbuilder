json.array!(@status_reports) do |status_report|
  json.extract! status_report, :project_id, :user_id, :yesterday, :today, :status_date
  json.url status_report_url(status_report, format: :json)
end
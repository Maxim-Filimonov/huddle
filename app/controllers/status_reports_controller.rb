class StatusReportsController < ApplicationController
  before_action :set_status_report, only: [:show, :edit, :update, :destroy]

  # GET /status_reports
  # GET /status_reports.json
  def index
    @status_reports = StatusReport.all
  end

  # GET /status_reports/1
  # GET /status_reports/1.json
  def show
  end

  # GET /status_reports/new
  def new
    @status_report = StatusReport.new
  end

  # GET /status_reports/1/edit
  def edit
  end

  # POST /status_reports
  # POST /status_reports.json
  def create
    @status_report = StatusReport.new(status_report_params)

    respond_to do |format|
      if @status_report.save
        format.html { redirect_to @status_report, notice: 'Status report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @status_report }
      else
        format.html { render action: 'new' }
        format.json { render json: @status_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /status_reports/1
  # PATCH/PUT /status_reports/1.json
  def update
    respond_to do |format|
      if @status_report.update(status_report_params)
        format.html { redirect_to @status_report, notice: 'Status report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @status_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status_reports/1
  # DELETE /status_reports/1.json
  def destroy
    @status_report.destroy
    respond_to do |format|
      format.html { redirect_to status_reports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status_report
      @status_report = StatusReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_report_params
      params.require(:status_report).permit(:project_id, :user_id, :yesterday, :today, :status_date)
    end
end

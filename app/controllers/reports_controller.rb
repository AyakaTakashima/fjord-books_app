# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports or /reports.json
  def index
    @reports = Report.order(:id).page(params[:page])
  end

  # GET /reports/1 or /reports/1.json
  def show; end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    if @report.user == current_user
      render :edit
    else
      redirect_to report_path(params[:id])
    end
  end

  # POST /reports or /reports.json
  def create
    # @report = Report.new(report_params)
    @report = current_user.reports.create(report_params)

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    if @report.user == current_user
      if @report.update(report_params)
        redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to report_path(params[:id])
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    if @report.user == current_user
      @report.destroy
      redirect_to @report, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      redirect_to report_path(params[:id])
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :content)
  end
end

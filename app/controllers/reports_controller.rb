class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy]
  before_action :pundit_authorization, only: %i[show index destroy]
  def create
    @report = current_user.reports.new(report_params)
    authorize @report
    if @report.save
      redirect_back(fallback_location: posts_path)
    else
      flash[:notice] = @report.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def show; end

  def index
    @report = Report.includes(:user)
  end

  def destroy
    if @report.destroy
      redirect_to reports_url, notice: 'report was successfully destroyed.'
    else
      flash[:notice] = @report.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def pundit_authorization
    authorize @report, policy_class: ReportPolicy
  end

  def set_report
    @report = Report.find_by(id: params[:id])
  end

  def report_params
    params.require(:report).permit(:reason, :reportable_id, :reportable_type)
  end
end

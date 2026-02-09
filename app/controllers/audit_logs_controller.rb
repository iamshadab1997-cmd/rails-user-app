class AuditLogsController < ApplicationController
  before_action :set_audit_log, only: [:show, :update, :destroy]

  # GET /audit_logs
  def index
    @audit_logs = AuditLog.all
    render json: { status: "success", data: @audit_logs }, status: :ok
  end

  # GET /audit_logs/:id
  def show
    render json: { status: "success", data: @audit_log }, status: :ok
  end

  # POST /audit_logs
  def create
    @audit_log = AuditLog.new(audit_log_params)
    if @audit_log.save
      render json: { status: "success", data: @audit_log }, status: :created
    else
      render json: { status: "error", errors: @audit_log.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /audit_logs/:id
  def update
    if @audit_log.update(audit_log_params)
      render json: { status: "success", data: @audit_log }, status: :ok
    else
      render json: { status: "error", errors: @audit_log.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /audit_logs/:id
  def destroy
    @audit_log.destroy
    render json: { status: "success", message: "Audit log deleted" }, status: :ok
  end

  private

  def set_audit_log
    @audit_log = AuditLog.find(params[:id])
  end

  def audit_log_params
    params.require(:audit_log).permit(:user_id, :action)
  end
end

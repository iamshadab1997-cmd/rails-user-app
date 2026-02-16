class AuditLogsController < ApplicationController
  before_action :set_audit_log, only: [ :show, :update, :destroy ]

  # GET /audit_logs
  def index
    audit_logs = AuditLog.page(params[:page]).per(10)

    render json: {
      status: "success",
      data: AuditLogSerializer.new(audit_logs).serializable_hash[:data],
      meta: {
        current_page: audit_logs.current_page,
        total_pages: audit_logs.total_pages,
        total_count: audit_logs.total_count
      }
    }, status: :ok
  end

  # GET /audit_logs/:id
  def show
    render json: {
      status: "success",
      data: AuditLogSerializer.new(@audit_log).serializable_hash[:data]
    }, status: :ok
  end

  # POST /audit_logs
  def create
    audit_log = AuditLog.new(audit_log_params)

    if audit_log.save
      render json: {
        status: "success",
        data: AuditLogSerializer.new(audit_log).serializable_hash[:data]
      }, status: :created
    else
      render json: {
        status: "error",
        errors: audit_log.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /audit_logs/:id
  def update
    if @audit_log.update(audit_log_params)
      render json: {
        status: "success",
        data: AuditLogSerializer.new(@audit_log).serializable_hash[:data]
      }, status: :ok
    else
      render json: {
        status: "error",
        errors: @audit_log.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /audit_logs/:id
  def destroy
    @audit_log.destroy
    render json: {
      status: "success",
      message: "Audit log deleted"
    }, status: :ok
  end

  private

  def set_audit_log
    @audit_log = AuditLog.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      errors: [ "Audit log not found" ]
    }, status: :not_found
  end

  def audit_log_params
    params.require(:audit_log).permit(:user_id, :action)
  end
end

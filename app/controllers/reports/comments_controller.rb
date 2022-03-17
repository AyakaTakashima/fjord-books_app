# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  include Commentable

  before_action :set_commentable
  before_action :set_render, only: %i[create]

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @report = Report.find(params[:report_id])
      flash.now[:alert] = t('errors.format', attribute: Comment.model_name.human, message: t('errors.messages.empty'))
      render @render
    end
  end

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def set_render
    @render = 'reports/show'
  end
end

# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    before_action :set_comment, only: %i[edit update destroy]
    before_action :set_render, only: %i[create]
  end

  def edit
    render '/comments/edit'
  end

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    elsif @render == 'reports/show'
      @report = Report.find(params[:report_id])
      flash.now[:alert] = t('errors.format', attribute: Comment.model_name.human, message: t('errors.messages.empty'))
      render @render
    else
      @book = Book.find(params[:book_id])
      flash.now[:alert] = t('errors.format', attribute: Comment.model_name.human, message: t('errors.messages.empty'))
      render @render
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

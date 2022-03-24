# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  include Commentable

  before_action :set_commentable
  before_action :set_render, only: %i[create]

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
    @report = @commentable
  end

  def set_render
    @render = 'reports/show'
  end
end

# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  include Commentable

  before_action :set_commentable
  before_action :set_render, only: %i[create]

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
    @book = @commentable
  end

  def set_render
    @render = 'books/show'
  end
end

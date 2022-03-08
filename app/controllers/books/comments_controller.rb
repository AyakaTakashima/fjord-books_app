# frozen_string_literal: true

class Books::CommentsController < CommentsController
  include Commentable

  before_action :set_commentable

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end

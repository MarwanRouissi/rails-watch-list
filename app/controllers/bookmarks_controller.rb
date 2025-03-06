class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end

  def create
    list = List.find(params[:list_id])
    comment = bookmark_params[:comment]
    movie = Movie.find(bookmark_params[:movie_id])
    @bookmark = Bookmark.new(comment: comment, movie: movie, list: list)
    @bookmark.save
    redirect_to list_path(list)
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to bookmark_path, status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end

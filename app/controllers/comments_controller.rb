class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create

    # params = comment_params

    @blog = Blog.find(params[:blog_id])
    @entry = @blog.entries.find(params[:entry_id])
    @comment = Comment.new(comment_params)

    # 作成直後はunapproved
    @comment.status = 'unapproved'

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_entry_url(@blog, @entry), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_entry_url(@blog, @entry), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve

    @blog = Blog.find(params[:blog_id])
    @entry = @blog.entries.find(params[:entry_id])
    @comment = @entry.comments.find(params[:comment_id])
    @comment.status = 'approved'

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_entry_url(@blog, @entry), notice: 'Comment was approved.' }
        format.json { render :show, status: :ok, location: blog_entry_url(@blog, @entry) }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @blog = Blog.find(params[:blog_id])
      @entry = @blog.entries.find(params[:entry_id])
      @comment = @entry.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :entry_id)
    end

    def blog_id_param
      params.permit(:body, :blog_id, :entry_id)[:blog_id]
    end

    def entry_id_param
      params.permit(:body, :blog_id, :entry_id)[:entry_id]
    end
end

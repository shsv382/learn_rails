class ArticlesController < ApplicationController
	
	def index
		@articles = Article.all
	end

	def popular
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.author_id = current_user.id
		if @article.save
			flash.notice = "Article '#{@article.title}' created!"
			redirect_to article_path(@article)
		else
			render 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
		if @article.view_counts == nil
			@article.view_counts = 1
			@article.save
		else
			@article.view_counts = @article.view_counts + 1
			@article.save
		end

	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash.notice = "Article '#{@article.title}' deleted!"
		redirect_to articles_path
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
  		@article.update(article_params)

  		flash.notice = "Article '#{@article.title}' updated!"

  		redirect_to article_path(@article)
	end

	private
	def article_params
		params.require(:article).permit(:title, :body, :tag_list, :image)
	end

end

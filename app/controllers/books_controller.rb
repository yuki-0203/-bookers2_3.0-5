class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
    @books= Book.new
    
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    @books = Book.all
    @user = current_user
    if @book.save
        redirect_to book_path(@book),notice:"Book was successfully created." 
    else
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
  if @book.user == current_user
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render 'edit'
    end
  end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
      @book.destoy
    end
      redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end

class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]


  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
    @book_comment = BookComment.new
    
    
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
    @book=Book.find(params[:id])
  if @book.user == current_user
    @book.destroy
  end
    redirect_to books_path
  end
  
   def ensure_correct_user
    @book=Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
   end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end

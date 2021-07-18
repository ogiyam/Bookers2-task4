class BooksController < ApplicationController

  before_action :authenticate_user!,except: [:top]

  def index
    @user = current_user
    @new_book = Book.new
    @books = Book.all
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
   if @new_book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@newbook)
   else
      @user = current_user
      @books = Book.all
      # @new_book = Book.new
      render "index"
   end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
       render "edit"
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      flash.now[:error] = @book.errors.full_messages
      render "edit"
    end
  end

  def destroy
     @book = Book.find(params[:id])
     @book.destroy
     redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

class ProfileController < ApplicationController
  def index
    @articles = Article.where('user_id = :user', { :user => current_user }).paginate(:page => params[:page], :per_page => 2)
  end
end
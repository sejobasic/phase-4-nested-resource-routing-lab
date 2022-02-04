class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    if params[:user_id]
      user = find_user
      item = user.items
    else
    item = Item.all
    end
    render json: item, include: :user
  end

  def show
    item = find_items
    render json: item
  end
  
  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end


  private

  def find_items
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found(invalid)
    render json: { errors: invalid }, status: :not_found
  end

end

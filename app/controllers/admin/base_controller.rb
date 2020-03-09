class Admin::BaseController < ApplicationController
  before_action :authenticate_staff!

  def check_resource_exists
    if @resource.nil?
      redirect_to admin_products_path, error: "resource not found"
    end
  end
end
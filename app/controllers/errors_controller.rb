class ErrorsController < ApplicationController
  def not_found
    render 'public/404', layout: false
  end
end

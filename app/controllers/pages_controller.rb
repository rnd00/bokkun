class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
    skip_authorization
  end
end

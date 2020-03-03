class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :desktop]

  def landing
    skip_authorization
  end

  def desktop
    skip_authorization
  end
end

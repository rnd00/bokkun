class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :home, :mobile]

  def landing
    skip_authorization
  end

  def home
    skip_authorization
  end

  def mobile
    skip_authorization
  end
end

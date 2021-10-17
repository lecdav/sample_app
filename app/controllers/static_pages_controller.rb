class StaticPagesController < ApplicationController
  def home
    @title_name = "Home"
  end

  def help
    @title_name = "Help"
  end

  def about
    @title_name = "About"
  end
end

class LeagueController < ApplicationController
  
  def show
    if params[:id].nil?
      @league = League.all()
    else
      @league = [League.find(params[:id])]
    end
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @league = League.new
  end
  
  def create
    @league = League.new(params[:league])
    respond_to do |format|
      if @league.save
        @league = [@league]
        format.html {render :action => "show", :id => @league.id}
      else
        format.html {render :action => "new"}
      end
    end
  end
  
end

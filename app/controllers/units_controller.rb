class UnitsController < ApplicationController
  # GET /units
  # GET /units.json
  def index
    @units = Unit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @units }
    end
  end

  # GET /units/1
  # GET /units/1.json
  def show
    @unit = Unit.find(params[:id])
    if (((current_user)&&(@unit.id==current_user.lease.unit.id))||(can? :manage, :all))
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @unit }
      end
    else
      flash[:error] = "Access Denied."
      redirect_to root_url
    end
  end

  # GET /units/new
  # GET /units/new.json
  def new
    @unit = Unit.new
    if ((!current_user)||(!can? :manage, :all))
      flash[:error] = "Access Denied."
      redirect_to root_url
    else

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unit }
    end
    end
  end

  # GET /units/1/edit
  def edit
    @unit = Unit.find(params[:id])
    if ((!current_user)||(!can? :manage, :all))
      flash[:error] = "Access Denied."
      redirect_to root_url
    end
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(params[:unit])

    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
        format.json { render json: @unit, status: :created, location: @unit }
      else
        format.html { render action: "new" }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /units/1
  # PUT /units/1.json
  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        format.html { redirect_to @unit, notice: 'Unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit = Unit.find(params[:id])
    if !current_user
      flash[:error] = "Access Denied."
      redirect_to root_url
    else
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to units_url }
      format.json { head :no_content }
    end
    end
  end
end

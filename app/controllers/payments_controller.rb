class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
    @approved_payments = Payment.where(:user_id => current_user)
    if !current_user
      flash[:error] = "Access Denied."
      redirect_to root_url
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @payments }
      end
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])
    if((!current_user) || ((@payment.user!=current_user) && (!can? :manage, :all)))
      flash[:error] = "Access Denied."
      redirect_to root_url
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @payment }
      end
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    @payment = Payment.new
    if !current_user
      flash[:error] = "Access Denied."
      redirect_to root_url
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @payment }
      end
    end
  end

  # GET /payments/1/edit
  # Deleted b/c this is a forbidden function

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(params[:payment])
    @payment.ip_address = request.remote_ip
    @payment.user = current_user
    @payment.lease = current_user.lease

    respond_to do |format|
      if @payment.save
        if @payment.make_transaction
          format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
          format.json { render json: @payment, status: :created, location: @payment }
        else
          @payment.destroy
          format.html { render action: "failed"}
        end
      else
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  # Deleted b/c this is a forbidden function

  # DELETE /payments/1
  # DELETE /payments/1.json
  # Deleted b/c this is a forbidden function
end

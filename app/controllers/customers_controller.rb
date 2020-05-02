# frozen_string_literal: true

class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find params[:id]
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new customer_params
    if @customer.save
      flash[:success] = t 'views.messages.successfully.created',
                          resource: t('activerecord.models.customer.one')
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
    @customer = Customer.find params[:id]
  end

  def update
    @customer = Customer.find params[:id]
    if @customer.update customer_params
      flash[:success] = t 'views.messages.successfully.updated',
                          resource: t('activerecord.models.customer.one')
      redirect_to @customer
    else
      render :edit
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    flash[:success] = t 'views.messages.successfully.destroyed',
                        resource: t('activerecord.models.customer.one')
    redirect_to customers_url
  end

  private

  def customer_params
    params.require(:customer).permit :name, :cpf, :email
  end
end

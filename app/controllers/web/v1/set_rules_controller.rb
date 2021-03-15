class Web::V1::SetRulesController < ApplicationController
  before_action :set_set_rule, only: [:show, :update, :destroy]

  # GET /web/v1/set_rules
  # GET /web/v1/set_rules.json
  def index
    @set_rules = SetRule.all.order("updated_at DESC").order("created_at DESC")

    render json: @set_rules
  end

  # GET /web/v1/set_rules/1
  # GET /web/v1/set_rules/1.json
  def show
    render json: @set_rule
  end

  # POST /web/v1/set_rules
  # POST /web/v1/set_rules.json
  def create
    @set_rule = SetRule.new(set_rule_params)
    @set_rule.days = params[:set_rule][:days]

    if @set_rule.save
      audit(@set_rule, current_user)
      render json: @set_rule, status: :created
    else
      render json: @set_rule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/set_rules/1
  # PATCH/PUT /web/v1/set_rules/1.json
  def update
    @set_rule = SetRule.find(params[:id])

    if @set_rule.update(set_rule_params)
      audit(@set_rule, current_user)
      head :no_content
    else
      render json: @set_rule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/set_rules/1
  # DELETE /web/v1/set_rules/1.json
  def destroy
    audit(@set_rule, current_user)
    @set_rule.destroy

    head :no_content
  end

  def delete_set_rules
   @set_rules = params[:set_rule_ids]
   @set_rules.each do |set_rule|
    SetRule.find(set_rule).delete
  end
end

private

def set_set_rule
  @set_rule = SetRule.find(params[:id])
end

def set_rule_params
  params.require(:set_rule).permit(:days, :category, :active)
end
end

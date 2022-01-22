class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:mypage]
  before_action :set_user, only: %i[ show mypage edit update ]

  def show
    user = User.find(params[:id])
    # @fixed_costs = user.fixed_costs.includes(:user)
    # binding.pry
    # @fixed_costs = FixedCost.all.includes(user: [:categories])
    @fixed_costs = user.fixed_costs.includes(user: [:categories])
    # @fixed_costs = @fixed_costs.eager_load(:monthly_annual)
    @comments = @user.comments
    @comment = @user.comments.build
    # params[:monthly_view] ? @monthly_view = "true" : params[:monthly_view]

    if params[:monthly_view].nil?
      @monthly_view = "true"
    else
      @monthly_view = params[:monthly_view]
    end

    # @costs = @fixed_costs.joins(:categories).group("categories.cat_name").sum(:payment).sort_by { |_, v| v }.reverse.to_h
    # まず月額の支出だけまとめる（１）
    # all_monthlies = @fixed_costs.joins(:categories).where("monthly_annual = ?", 0).group("categories.cat_name").sum(:payment)
    all_monthlies = @fixed_costs.joins(:categories).where(monthly_annual: 0).group("categories.cat_name").sum(:payment)
    # 年額の支出だけまとめる（２）
    all_annuals = @fixed_costs.joins(:categories).where(monthly_annual: 1).group("categories.cat_name").sum(:payment)

    # 月額表示の場合
    # （２）を月額に変換
    if @monthly_view == "true"
      # binding.pry
      all_annuals = all_annuals.map{|key, value| [key, value/12]}.to_h
      # （１）と（２）を合計し、月額として@costsに代入
      @costs = all_monthlies.merge(all_annuals){|key, v1, v2| v1 + v2}.sort_by { |_, v| v }.reverse
    else
    # 年額表示の場合
      # （１）を年額に変換
      all_monthlies = all_monthlies.map{|key, value| [key, value*12]}.to_h
      # （１）と（２）を合計し、月額として@costsに代入
      @costs = all_monthlies.merge(all_annuals){|key, v1, v2| v1 + v2}.sort_by { |_, v| v }.reverse
    end
  end

  # def mypage
  #   #redirect_to user_path(current_user)
  # end

  def edit
    redirect_to user_path(@user) unless @user == current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end


  private

    def set_user
      @user = User.find(params[:id])
    end
end

class QuestsController < ApplicationController
  skip_load_and_authorize_resource :only => [:index]
  skip_before_action :logged_in_admin

  def index
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest2
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest3
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest4
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest5
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest6
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest7
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest8
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest9
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def quest10
    # current_user = Admin.first
    @quests = Quest.all
    ar = []
    Quest.all.each do |a|
      a.field_10.each do |b|
        ar << b
      end
    end
    @quest2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}
    @r = @quest2.sort_by(&:last).reverse

    respond_to do |format|
      format.html { render layout: false }
    end
  end
end

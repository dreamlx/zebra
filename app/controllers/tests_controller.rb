class TestsController < ApplicationController
  skip_load_and_authorize_resource :only => [:index]
  skip_before_action :logged_in_admin, :only => [:index]

  def index
    # current_user = Admin.first
    @tests = Test.all
    ar = []
    Test.all.each do |a|
      a.field_5.each do |b|
        ar << b
      end
    end
    @test2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def test2
    # current_user = Admin.first
    @tests = Test.all
    ar = []
    Test.all.each do |a|
      a.field_5.each do |b|
        ar << b
      end
    end
    @test2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def test3
    # current_user = Admin.first
    @tests = Test.all
    ar = []
    Test.all.each do |a|
      a.field_5.each do |b|
        ar << b
      end
    end
    @test2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def test4
    # current_user = Admin.first
    @tests = Test.all
    ar = []
    Test.all.each do |a|
      a.field_5.each do |b|
        ar << b
      end
    end
    @test2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def test5
    # current_user = Admin.first
    @tests = Test.all
    ar = []
    Test.all.each do |a|
      a.field_5.each do |b|
        ar << b
      end
    end
    @test2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def test6
    # current_user = Admin.first
    @tests = Test.all
    ar = []
    Test.all.each do |a|
      a.field_5.each do |b|
        ar << b
      end
    end
    @test2 = ar.inject(Hash.new(0)) {|h, v| h[v] += 1; h}

    respond_to do |format|
      format.html { render layout: false }
    end
  end
end

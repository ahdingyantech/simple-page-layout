# coding: utf-8
require 'spec_helper'

describe 'test.html.haml' do
  before(:each) {
    render :template => 'test', :layout => 'test_layout'
  }
  it {puts rendered}
  it {rendered.should have_selector('div')}
end
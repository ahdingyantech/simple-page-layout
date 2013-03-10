# coding: utf-8
require 'spec_helper'

describe 'test.html.haml' do
  before(:each) {
    render :template => 'test', :layout => 'layout'
  }
  it {puts rendered}

  it {rendered.should have_selector('html[lang=zh]')}
  it {rendered.should_not have_selector('html[lang=en]')}

  it 'test html' do
    rendered.should have_selector('html') do |html|
      html.should have_selector('head') do |head|
        head.should have_selector('title', :content => 'test site | hello')
        head.should have_selector('link', :href => '/assets/application.css')
      end
    end
  end

  it 'test body' do
    rendered.should have_selector('body') do |body|
      body.should have_selector('.page-content .foo', :content => 'bar')
      body.should have_selector('script', :src => '/assets/application.js')
    end
  end
end
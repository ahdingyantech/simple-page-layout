# coding: utf-8
require 'spec_helper'

describe 'test/test.html.haml' do
  it 'should be rendered' do
    render
    p rendered
  end
end
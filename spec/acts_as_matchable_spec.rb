require File.dirname(__FILE__) + '/spec_helper'

describe "ActsAsMatchable" do

  comment = 'My name is Fred and my SSN is 422-11-0000'
  test = MatchableTest.new(:comments => comment)

  it "should match the text literal 'SSN'" do
    test.pattern_match(/SSN/).should  == {"comments"=>comment}
  end

  it "should match a numeric pattern for SSN" do
    test.pattern_match(/\d\d\d[-]\d\d[-]\d\d\d\d/).should == {"comments"=>comment}
  end

  it "should not match the text literal 'Phone'" do
    test.pattern_match(/Phone/).should equal(nil)
  end

  it "should not match a numeric pattern for phone number" do
    test.pattern_match(/\d\d\d[-]\d\d\d[-]\d\d\d\d/).should equal(nil)
  end
end
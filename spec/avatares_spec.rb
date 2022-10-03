require 'spec_helper'

describe Avatares do
  it "should be valid" do
    expect(Avatares).to be_a(Module)
  end

  it "has a version number" do
    assert Avatares::VERSION
  end
end

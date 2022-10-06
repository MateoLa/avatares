require 'spec_helper'

describe "Avatares::Models::Avatarable through Actor" do
  it "should have an Avatar" do
    valentino = Actor.create!(name: "Rodolfo")

    assert valentino.avatar
  end

end

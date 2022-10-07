require 'spec_helper'

# ImageMagick must be installed on your test environmet to run this test.
# Check if you have it installed by running: > convert -version
describe "Avatares::Models::Avatarable through Actor" do
  it "should have an Avatar" do
    valentino = Actor.create!(name: "Rodolfo")
    assert valentino.avatar
  end

end

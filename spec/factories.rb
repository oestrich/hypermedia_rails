FactoryGirl.define do
  factory(:order) do
    date { Date.today }
    total_cents { 5000 }
    status { "charged" }
  end
end

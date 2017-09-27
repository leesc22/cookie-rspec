require 'byebug'
require 'rspec'

require_relative 'cookie'

describe Cookie do

  let(:type)   { "peanut butter" }
  let(:cookie) { Cookie.new(type) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Cookie of the specified type" do
        expect(cookie.type).to eq(type)
      end
    end

    context "with invalid input" do
      it "throws an argument error when not given a type argument" do
        expect { Cookie.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#type" do
    it "returns the type of the cookie" do
      expect(cookie.type).to eq(type)
    end
  end

  describe "#bake!" do
    it "requires an integer time argument" do
      expect(cookie).to receive(:bake!).with(an_instance_of(Integer))
      cookie.bake!(5)
    end

    it "returns the cookie object" do
      expect(cookie.bake!(5)).to be_a_kind_of(Cookie)
    end

    it "changes the status of the cookie when given enough time" do
      expect { cookie.bake!(10) }.to change(cookie, :status)
    end
  end

  describe "#status" do
    it "returns the cookie's current status" do
      expect([:doughy, :almost_ready, :ready, :burned]).to include(cookie.status)
    end

    context "when unbaked" do
      it "is `:doughy`" do
        expect(cookie.status).to eq :doughy
      end
    end

    context "when baked for less than 7 minutes" do
      it "is `:doughy`" do
        cookie.bake!(6)
        expect(cookie.status).to eq :doughy
      end
    end

    context "when baked for at least 7 but less than 10 minutes" do
      it "is `:almost_ready`" do
        cookie.bake!(9)
        expect(cookie.status).to eq :almost_ready
      end
    end

    context "when baked for at least 10 but less than 12 minutes" do
      it "is `:ready`" do
        cookie.bake!(11)
        expect(cookie.status).to eq :ready
      end
    end

    context "when baked for at least 12 minutes" do
      it "is `:burned`" do
        cookie.bake!(12)
        expect(cookie.status).to eq :burned
      end
    end
  end
end
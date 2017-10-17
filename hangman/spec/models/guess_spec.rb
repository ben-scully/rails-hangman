require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:letter) { 'p' }
  let(:game) { Game.new(secret_word: 'pirate') }
  let(:guess) { Guess.new(game: game, letter: letter) }

  before do
    guess.save
  end

  describe "create" do
    context "when letter is nil" do
      let(:letter) { nil }

      it "returns invalid" do
        expect(guess).not_to be_valid
      end
    end

    context "when letter is an empty string" do
      let(:letter) { '' }

      it "returns invalid" do
        expect(guess).not_to be_valid
      end
    end

    context "when letter is non-alphabetic" do
      let(:letter) { '$' }

      it "returns invalid" do
        expect(guess).not_to be_valid
      end
    end

    context "when given multiple characters instead of one letter" do
      let(:letter) { 'wizard' }

      it "returns invalid" do
        expect(guess).not_to be_valid
      end
    end

    context "when Guess doesn't belong to a Game" do
      let(:letter) { 'w' }
      let(:guess) { Guess.new(letter: letter) }

      it "returns invalid" do
        expect(guess).not_to be_valid
      end
    end

    context "when given letter which is not unique" do
      let(:guess2) { Guess.new(game: game, letter: letter) }

      before do
        guess2.save
      end

      it "returns invalid" do
        expect(guess2).not_to be_valid
      end
    end
  end

  describe 'post create' do
    context "when letter is uppercase" do
      let(:letter) { 'P' }

      it "returns valid" do
        expect(guess).to be_valid
      end
    end
  end
end

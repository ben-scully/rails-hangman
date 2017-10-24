require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:presence_of) { "Letter can't be blank" }
  let(:length_of) { "Letter is too long (maximum is 1 character)" }
  let(:format_of) { "Letter #{Guess::ONLY_ALPHABETIC}" }
  let(:uniqueness_of) { "Letter #{Guess::REPEATED_GUESS}" }
  let(:letter) { 'p' }
  let(:game) { Game.create!(secret_word: 'pirate') }

  subject(:guess) { game.guesses.create(letter: letter) }

  describe 'valid create' do
    context "when letter is valid" do
      it "returns valid" do
        expect(guess).to be_valid
      end
    end
  end

  describe "invalid create" do
    let(:guess_errors) { guess.errors.full_messages.sort }

    context "when letter is nil" do
      let(:letter) { nil }
      let(:errors) { [presence_of, format_of].sort }

      it "returns invalid" do
        expect(guess).not_to be_valid
        expect(guess_errors).to eql(errors)
      end
    end

    context "when letter is an empty string" do
      let(:letter) { '' }
      let(:errors) { [presence_of, format_of].sort }

      it "returns invalid" do
        expect(guess).not_to be_valid
        expect(guess_errors).to eql(errors)
      end
    end

    context "when letter is non-alphabetic" do
      let(:letter) { '$' }
      let(:errors) { [format_of].sort }

      it "returns invalid" do
        expect(guess).not_to be_valid
        expect(guess_errors).to eql(errors)
      end
    end

    context "when given multiple characters instead of one letter" do
      let(:letter) { 'wizard' }
      let(:errors) { [length_of].sort }

      it "returns invalid" do
        expect(guess).not_to be_valid
        expect(guess_errors).to eql(errors)
      end
    end

    context "when given multiple characters instead of one letter including non-alphabetic" do
      let(:letter) { 'wi77rd' }
      let(:errors) { [length_of, format_of].sort }

      it "returns invalid" do
        expect(guess).not_to be_valid
        expect(guess_errors).to eql(errors)
      end
    end

    context "when given letter which is not unique" do
      let(:errors) { [uniqueness_of].sort }

      before do
        game.guesses.create(letter: letter)
      end

      it "returns invalid" do
        expect(guess).not_to be_valid
        expect(guess_errors).to eql(errors)
      end
    end
  end

  describe 'post valid create' do
    context "when letter is uppercase" do
      let(:letter) { 'P' }
      let(:letter_downcase) { 'p' }

      it "returns valid" do
        expect(guess.letter).to eql(letter_downcase)
      end
    end
  end
end

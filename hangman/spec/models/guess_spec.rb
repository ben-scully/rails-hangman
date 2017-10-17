require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:letter) { 'p' }
  let(:game) { Game.new(secret_word: 'pirate') }
  let(:guess) { Guess.new(game: game, letter: letter) }

  before do
    guess.save
  end

  context "when creating Guess" do
    let(:game_exist) { 'Game must exist' }
    let(:presence) { "Letter can't be blank" }
    let(:min_length) { 'Letter is too long (maximum is 1 character)' }
    let(:alphabetic) { 'Letter must be an alphabetic character [s,w,g NOT @,*,4]' }
    let(:unique) { 'Letter has already been guessed' }

    before do
      @errors = guess.errors.full_messages
    end

    context "when given letter which is nil" do
      let(:letter) { nil }
      let(:test_errors) { [presence, alphabetic] }

      it "error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when given letter which is an empty string" do
      let(:letter) { '' }
      let(:test_errors) { [presence, alphabetic] }

      it "error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when given letter which is correct length but contains non-alphabetic characters" do
      let(:letter) { '$' }
      let(:test_errors) { [alphabetic] }

      it "error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when given letter which is too many characters" do
      let(:letter) { 'wizard' }
      let(:test_errors) { [min_length] }

      it "error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when Guess doesn't belong to a Game" do
      let(:letter) { 'w' }
      let(:guess) { Guess.new(letter: letter) }
      let(:test_errors) { [game_exist] }

      it "error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when given letter which is not unique" do
      let(:test_errors) { [unique] }

      before do
        guess2 = Guess.new(game: game, letter: letter)
        guess2.save
        @errors2 = guess2.errors.full_messages
      end

      it "error message(s)" do
        expect((test_errors - @errors2).empty?).to be_truthy
      end
    end
  end

  context "when given letter which is an uppercase character" do
    let(:letter) { 'Z' }

    it "letter is downcased" do
      expect(guess.letter).to eql(letter.downcase)
    end
  end
end

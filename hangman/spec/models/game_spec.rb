require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:secret_word) { 'pirates' }

  subject(:game) { described_class.new(secret_word: secret_word) }

  before do
    game.save
  end

  describe "create" do
    context "when secret_word is nil" do
      let(:secret_word) { nil }

      it "returns invalid" do
        expect(game).not_to be_valid
      end
    end

    context "when secret_word is empty string" do
      let(:secret_word) { '' }

      it "returns invalid" do
        expect(game).not_to be_valid
      end
    end

    context "when secret_word is too short" do
      let(:secret_word) { 'as' }

      it "returns invalid" do
        expect(game).not_to be_valid
      end
    end

    context "when secret_word is too short and contains non-alphabetic characters" do
      let(:secret_word) { 'a2' }

      it "returns invalid" do
        expect(game).not_to be_valid
      end
    end

    context "when secret_word is long enough but contains non-alphabetic characters" do
      let(:secret_word) { 'a2dfs$' }

      it "returns invalid" do
        expect(game).not_to be_valid
      end
    end

    context "when secret_word is valid" do
      it "returns valid" do
        expect(game).to be_valid
      end
    end
  end

  describe 'post create' do
    context "when secret_word contains uppercase characters" do
      let(:secret_word) { 'PIRATES' }

      it "returns downcased secret_word" do
        expect(game.secret_word).to eql(secret_word.downcase)
      end
    end
  end

  describe '#lives' do
    let(:lives) { secret_word.length }

    context "post create" do
      it "returns original lives" do
        expect(game.lives).to eql(lives)
      end
    end

    context "after a guess" do
      before do
        guess = Guess.new(game: game, letter: letter)
        guess.save
      end

      context "one incorrect guess" do
        let(:lives) { secret_word.length - 1 }
        let(:letter) { 'z' }

        it "returns original lives less one" do
          expect(game.lives).to eql(lives)
        end
      end

      context "one correct guess" do
        let(:letter) { 'p' }

        it "returns original lives less one" do
          expect(game.lives).to eql(lives)
        end
      end
    end
  end

  # TODO where do I put these helpers?
  def new_guesses(game, letters)
    letters.map { |letter| new_guess(game, letter) }
  end

  def new_guess(game, letter)
    Guess.new(game: game, letter: letter).save
  end

  describe '#guessed_letters' do
    let(:guessed_letters) { [] }

    before do
      new_guesses(game, guessed_letters)
    end

    context "post create" do
      it "returns no guesses" do
        expect(game.guessed_letters).to eql(guessed_letters)
      end
    end

    context "guessed have been made" do
      let(:guessed_letters) { %w[p i r a t e s] }

      it "returns guessed letters" do
        expect(game.guessed_letters).to eql(guessed_letters)
      end
    end
  end

  describe '#game_finished?' do
    context "post create" do
      let(:finshed) { false }

      it "returns game not finished" do
        expect(game.game_finished?).to eql(finshed)
      end
    end

    context 'game has finished' do
      let(:letters) { %w[p i r a t e s] }

      before do
        new_guesses(game, letters)
      end

      context "when won" do
        let(:finshed) { true }

        it "returns game finished" do
          expect(game.game_finished?).to eql(finshed)
        end
      end

      context "when lost" do
        let(:finshed) { true }
        let(:letters) { %w[z q w l m g y] }

        it "returns game finished" do
          expect(game.game_finished?).to eql(finshed)
        end
      end
    end
  end

  describe '#won?' do
    context "post create" do
      let(:won) { false }

      it "returns game not won" do
        expect(game.won?).to eql(won)
      end
    end

    context 'game has finished' do
      def new_guesses(game, letters)
        letters.map { |letter| new_guess(game, letter) }
      end

      def new_guess(game, letter)
        Guess.new(game: game, letter: letter).save
      end

      let(:letters) { %w[p i r a t e s] }

      before do
        new_guesses(game, letters)
      end

      context "when every letter has been guessed" do
        let(:won) { true }

        it "returns game won" do
          expect(game.won?).to eql(won)
        end
      end

      context "when all lives are gone" do
        let(:won) { false }
        let(:letters) { %w[z q w l m g y] }

        it "returns game won" do
          expect(game.won?).to eql(won)
        end
      end

      context "when every letter has been guessed but all lives have been lost" do
        let(:won) { false }
        let(:letters) { %w[z q w l m g y p i r a t e s] }

        it "returns game not won" do
          expect(game.won?).to eql(won)
        end
      end
    end
  end

  describe '#lost?' do
    context "post create" do
      let(:lost) { false }

      it "returns game not lost" do
        expect(game.lost?).to eql(lost)
      end
    end

    context 'game has finished' do
      def new_guesses(game, letters)
        letters.map { |letter| new_guess(game, letter) }
      end

      def new_guess(game, letter)
        Guess.new(game: game, letter: letter).save
      end

      let(:letters) { %w[p i r a t e s] }

      before do
        new_guesses(game, letters)
      end

      context "when every letter has been guessed" do
        let(:lost) { false }

        it "returns game lost" do
          expect(game.lost?).to eql(lost)
        end
      end

      context "when all lives are gone" do
        let(:lost) { true }
        let(:letters) { %w[z q w l m g y] }

        it "returns game lost" do
          expect(game.lost?).to eql(lost)
        end
      end

      context "when every letter has been guessed but all lives have been lost" do
        let(:lost) { true }
        let(:letters) { %w[z q w l m g y p i r a t e s] }

        it "returns game not lost" do
          expect(game.lost?).to eql(lost)
        end
      end
    end
  end
end

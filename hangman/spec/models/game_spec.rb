require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game_has_not_begun) { "Game #{GamesHelper::UNCHANGEABLE_AFTER_GUESS_MADE}" }
  let(:presence_of) { "Secret word can't be blank" }
  let(:length_of) { "Secret word is too short (minimum is 3 characters)" }
  let(:format_of) { "Secret word #{GamesHelper::ONLY_ALPHABETIC}" }
  let(:secret_word) { 'pirates' }

  subject(:game) { described_class.create(secret_word: secret_word) }

  describe 'valid create' do
    context "when secret_word is valid" do
      it "returns valid" do
        expect(game).to be_valid
      end
    end
  end

  describe 'invalid create' do
    let(:game_errors) { game.errors.full_messages.sort }

    context "when secret_word is nil" do
      let(:secret_word) { nil }
      let(:errors) { [presence_of, length_of, format_of].sort }

      it "returns invalid" do
        expect(game).not_to be_valid
        expect(game_errors).to eql(errors)
      end
    end

    context "when secret_word is empty string" do
      let(:secret_word) { '' }
      let(:errors) { [presence_of, length_of, format_of].sort }

      it "returns invalid" do
        expect(game).not_to be_valid
        expect(game_errors).to eql(errors)
      end
    end

    context "when secret_word is too short" do
      let(:secret_word) { 'as' }
      let(:errors) { [length_of].sort }

      it "returns invalid" do
        expect(game).not_to be_valid
        expect(game_errors).to eql(errors)
      end
    end

    context "when secret_word is too short and contains non-alphabetic characters" do
      let(:secret_word) { 'a2' }
      let(:errors) { [length_of, format_of].sort }

      it "returns invalid" do
        expect(game).not_to be_valid
        expect(game_errors).to eql(errors)
      end
    end

    context "when secret_word is long enough but contains non-alphabetic characters" do
      let(:secret_word) { 'a2dfs$' }
      let(:errors) { [format_of].sort }

      it "returns invalid" do
        expect(game).not_to be_valid
        expect(game_errors).to eql(errors)
      end
    end
  end

  describe 'post valid create' do
    context "when secret_word contains uppercase characters" do
      let(:secret_word) { 'PIRATES' }
      let(:secret_word_downcase) { 'pirates' }

      it "returns downcased secret_word" do
        expect(game.secret_word).to eql(secret_word_downcase)
      end
    end
  end

  describe 'invalid update' do
    let(:secret_word_update) { 'pira' }

    before do
      game.update(secret_word: secret_word_update)
    end

    context "when Game is updated before a Guess has been made" do
      it "returns valid" do
        expect(game).to be_valid
      end
    end

    context "when Game is updated after a Guess has been made" do
      let(:game_errors) { game.errors.full_messages.sort }
      let(:errors) { [game_has_not_begun].sort }

      before do
        game.guesses.create(letter: 'p')
      end

      it "returns invalid" do
        expect(game).not_to be_valid
        expect(game_errors).to eql(errors)
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
        game.guesses.create!(letter: letter)
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

        it "returns original lives" do
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
    game.guesses.create!(letter: letter).save
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
      let(:guessed_letters) { %w[p i r a t e s].sort }

      it "returns guessed letters" do
        expect(game.guessed_letters).to eql(guessed_letters)
      end
    end
  end

  describe '#game_finished?' do
    context "post create" do
      it "returns game not finished" do
        expect(game).not_to be_game_finished
      end
    end

    context 'game has finished' do
      # TODO use / ask about fixtures
      let(:letters) { secret_word.chars }

      before do
        new_guesses(game, letters)
      end

      context "when won" do
        it "returns game finished" do
          expect(game).to be_game_finished
        end
      end

      context "when lost" do
        let(:letters) { %w[z q w l m g y] }

        it "returns game finished" do
          expect(game).to be_game_finished
        end
      end
    end
  end

  describe '#won?' do
    context "post create" do
      it "returns game not won" do
        expect(game).not_to be_won
      end
    end

    context 'game has finished' do
      let(:letters) { %w[p i r a t e s] }

      before do
        new_guesses(game, letters)
      end

      context "when every letter has been guessed" do
        it "returns game won" do
          expect(game).to be_won
        end
      end

      context "when all lives are gone" do
        let(:letters) { %w[z q w l m g y] }

        it "returns game won" do
          expect(game).not_to be_won
        end
      end

      context "when every letter has been guessed but all lives have been lost" do
        let(:letters) { %w[z q w l m g y p i r a t e s] }

        it "returns game not won" do
          expect(game).not_to be_won
        end
      end
    end
  end

  describe '#lost?' do
    context "post create" do
      it "returns game not lost" do
        expect(game).not_to be_lost
      end
    end

    context 'game has finished' do
      let(:letters) { %w[p i r a t e s] }

      before do
        new_guesses(game, letters)
      end

      context "when every letter has been guessed" do
        it "returns game lost" do
          expect(game).not_to be_lost
        end
      end

      context "when all lives are gone" do
        let(:letters) { %w[z q w l m g y] }

        it "returns game lost" do
          expect(game).to be_lost
        end
      end

      context "when every letter has been guessed but all lives have been lost" do
        let(:letters) { %w[z q w l m g y p i r a t e s] }

        it "returns game not lost" do
          expect(game).to be_lost
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe GamesHelper, type: :helper do
  describe '#success_message' do
    let(:won) { true }
    let(:message) { 'You WON!' }

    context 'when won is true' do
      it 'returns success message' do
        expect(success_message(won)).to eq(message)
      end
    end

    context 'when won is false' do
      let(:won) { false }
      let(:message) { 'You LOST!' }

      it 'returns success message' do
        expect(success_message(won)).to eq(message)
      end
    end
  end

  let(:secrets) { %w[p i r a t e s] }
  let(:guesses) { %w[p i r] }
  let(:masked)  { "p i r _ _ _ _" }

  describe '#masked_letters' do
    context 'when given some correct guesses' do
      it 'returns masked string' do
        expect(masked_letters(secrets, guesses)).to eq(masked)
      end
    end

    context 'when given some incorrect guesses' do
      let(:guesses) { %w[z y q] }
      let(:masked)  { "_ _ _ _ _ _ _" }

      it 'returns masked string' do
        expect(masked_letters(secrets, guesses)).to eq(masked)
      end
    end
  end

  describe '#guessed_letters' do
    let(:guesses_string) { GamesHelper::NO_GUESS_MADE }

    context 'when given no guesses' do
      let(:guesses) { [] }

      it 'returns empty string' do
        expect(guessed_letters(guesses)).to eq(guesses_string)
      end
    end

    context 'when given some guesses' do
      let(:guesses_string) { 'p i r' }

      it 'returns guesses as string' do
        expect(guessed_letters(guesses)).to eq(guesses_string)
      end
    end
  end
end

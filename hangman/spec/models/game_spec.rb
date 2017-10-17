require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:secret_word) { 'pirates' }

  subject(:game) { described_class.new(secret_word: secret_word) }

  before do
    game.save
  end

  context "when creating Game" do
    let (:presence) { "Secret word can't be blank" }
    let (:min_length) { 'Secret word is too short (minimum is 3 characters)' }
    let (:alphabetic) { 'Secret word is only allowed to contain alphabetic characters [s,w,g NOT @,*,4]' }

    before do
      @errors = game.errors.full_messages
    end

    context "when secret_word is nil" do
      let(:secret_word) { nil }
      let(:test_errors) { [presence, min_length, alphabetic] }

      it "match error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when secret_word is empty string" do
      let(:secret_word) { '' }
      let(:test_errors) { [presence, min_length, alphabetic] }

      it "match error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when secret_word is too short" do
      let(:secret_word) { 'as' }
      let(:test_errors) { [min_length] }

      it "match error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when secret_word is too short and contains non-alphabetic characters" do
      let(:secret_word) { 'a2' }
      let(:test_errors) { [min_length, alphabetic] }

      it "match error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end

    context "when secret_word is long enough but contains non-alphabetic characters" do
      let(:secret_word) { 'a2dfs$' }
      let(:test_errors) { [alphabetic] }

      it "match error message(s)" do
        expect((test_errors - @errors).empty?).to be_truthy
      end
    end
  end

  context "when secret_word contains uppercase characters" do
    let(:secret_word) { 'PIRATES' }

    it "secret_word is downcased" do
      expect(game.secret_word).to eql(secret_word.downcase)
    end
  end
end

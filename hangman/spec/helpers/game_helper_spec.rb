require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GameHelper. For example:
#
# describe GameHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
# RSpec.describe GameHelper, type: :helper do
#   let(:secrect_letters) { "%w{p i r a t e s}" }
#   let(:guessed_letters) { "%w{p i r}" }
#   let(:masked_letters)  { "%w{p i r _ _ _ _}" }
#
#   describe '#masked_letters' do
#     it 'returns string' do
#       expect(helper.masked_letters(secret_letters, guessed_letters)).to eq(masked_letters)
#     end
#   end
# end



# def masked_letters(secret_letters, guessed_letters)
#   secret_letters.map { |letter| guessed_letters.include?(letter) ? letter : '_' }.join(' ')
# end
#
# def guessed_letters(guessed_letters)
#   guessed_letters.empty? ? 'no guesses made' : guessed_letters.each { |letter| letter }.join(' ')
# end
#
# def success_message(won)
#   won ? 'You WON!' : 'You LOST!'
# end

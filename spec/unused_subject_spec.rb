# frozen_string_literal: true

RSpec.describe RSpectre do
  include_examples 'highlighted offenses', <<~RUBY
    RSpec.describe 'unused subjects' do
      subject { 'foo' }

      describe 'some property' do
        subject { super() + 'bar' }

        it 'handles super()' do
          expect(subject).to eql('foobar')
        end
      end

      context 'named' do
        subject(:named) { 'a' }
        ^^^^^^^^^^^^^^^ UnusedSubject: Unused `subject` definition.
      end

      context 'anonymous' do
        subject { 'a' }
        ^^^^^^^ UnusedSubject: Unused `subject` definition.
      end

      context 'named but referenced anonymous' do
        subject(:not_directly_referenced) { 'a' }

        specify { expect(subject).to eql('a') }
      end
    end
  RUBY
end

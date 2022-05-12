# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe '.generate_short_slug' do
    let(:url) { Url.new(original_url: 'https://www.example.com') }

    before do
      url.generate_short_slug
    end

    context 'generate normal short slug' do
      it { expect(url.shortened_slug =~ /^[a-zA-Z0-9]+$/).to eq 0 }
    end
  end

  describe '.generate_sanitized_url' do
    let(:url) { Url.new(original_url: original_url) }

    before do
      url.generate_sanitized_url
    end

    context 'when normal URL' do
      let(:original_url) { 'https://www.example.com' }

      it { expect(url.sanitized_url).to eq 'https://www.example.com' }
    end

    context 'when URL is javascript code (XSS attack)' do
      let(:original_url) { 'javascript:alert("1");' }

      it { expect(url.sanitized_url).to eq 'about:blank' }
    end

    context 'when original url have NO specific protocol' do
      let(:original_url) { 'www.example.com' }

      it 'return sanitized url with http protocol' do
        expect(url.sanitized_url).to eq 'http://www.example.com'
      end
    end

    context 'when evil URL that are encoded with Unicode numerical character references' do
      let(:original_url) do
        '&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#49;&#39;&#41;'
      end

      it { expect(url.sanitized_url).to eq 'about:blank' }
    end

    context 'when evil URL that are encoded with Unicode numerical character references' do
      let(:original_url) do
        '&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#49;&#39;&#41;'
      end

      it { expect(url.sanitized_url).to eq 'about:blank' }
    end

    context 'when evil URLs that are URL-encoded (hex with %)' do
      let(:original_url) do
        '%6A%61%76%61%73%63%72%69%70%74%3A%61%6C%65%72%74%28%22%58%53%53%22%29'
      end

      it { expect(url.sanitized_url).to eq 'about:blank' }
    end

    context 'when have URL-encoded characters in the protocol' do
      let(:original_url) { 'h%74tps://example.com' }

      it { expect(url.sanitized_url).to eq 'https://example.com' }
    end

    context 'when have decimal numeric character in the protocol' do
      let(:original_url) { 'h&#116;tps://example.com' }

      it { expect(url.sanitized_url).to eq 'https://example.com' }
    end

    context 'when have hex numeric character in the protocol' do
      let(:original_url) { 'h&#x74;tps://example.com' }

      it { expect(url.sanitized_url).to eq 'https://example.com' }
    end

    context 'when have URL-encoded characters in the opaque portion' do
      let(:original_url) { 'https://example%40.com' }

      it 'retains URL-encoded characters' do
        expect(url.sanitized_url).to eq 'https://example%40.com'
      end
    end

    context 'when have no root domain name' do
      let(:original_url) { 'https://' }

      it { expect(url.sanitized_url).to eq 'about:blank' }
    end
  end
end

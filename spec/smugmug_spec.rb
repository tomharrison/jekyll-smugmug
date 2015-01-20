require 'spec_helper'

describe Jekyll::SmugmugImgTag do
  include_context 'fixtures'

  def img_tag(url, alt = '')
    %Q(<img src="#{url}" alt="#{alt}" class="smphoto" />)
  end

  describe '.initialize' do
    it 'should throw an exception for invalid dimensions' do
      invalid_dimensions.each do |d|
        liquid = "{% smugmug dimensions: #{d} guid: #{guid} %}"
        expect do
          Liquid::Template.parse(liquid).render
        end.to raise_error
      end
    end
  end

  describe '.render' do
    describe 'hard-coded guid' do
      it 'should render for a pre-defined size' do
        predefined_size_test_cases.each do |size, url|
          liquid = "{% smugmug dimensions: #{size} guid: #{guid} %}"
          rendered = Liquid::Template.parse(liquid).render
          expect(rendered).to include img_tag(url)
        end
      end

      it 'should render for a custom size' do
        custom_size_test_cases.each do |size, url|
          liquid = "{% smugmug dimensions: #{size} guid: #{guid} %}"
          rendered = Liquid::Template.parse(liquid).render
          expect(rendered).to include img_tag(url)
        end
      end
    end

    describe 'guid from context' do
      it 'should render for a pre-defined size' do
        predefined_size_test_cases.each do |size, url|
          liquid = "{% smugmug dimensions: #{size} guid: my_guid %}"
          rendered = Liquid::Template.parse(liquid).render 'my_guid' => guid
          expect(rendered).to include img_tag(url)
        end
      end

      it 'should render for a custom size' do
        custom_size_test_cases.each do |size, url|
          liquid = "{% smugmug dimensions: #{size} guid: my_guid %}"
          rendered = Liquid::Template.parse(liquid).render 'my_guid' => guid
          expect(rendered).to include img_tag(url)
        end
      end
    end

    describe 'alt tag' do
      it 'should render' do
        test_cases = predefined_size_test_cases.merge(custom_size_test_cases)
        test_cases.each do |size, url|
          liquid = "{% smugmug dimensions: #{size} guid: #{guid} alt: '#{alt}' %}"
          rendered = Liquid::Template.parse(liquid).render
          expect(rendered).to include img_tag(url, alt)
        end
      end
    end
  end
end

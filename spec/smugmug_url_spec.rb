require 'spec_helper'

describe Jekyll::SmugmugUrlTag do
  include_context 'fixtures'

  describe '.initialize' do
    it 'should throw an exception for invalid dimensions' do
      invalid_dimensions.each do |d|
        liquid = "{% smugmug_url dimensions: #{d} guid: #{guid} %}"
        expect do
          Liquid::Template.parse(liquid).render
        end.to raise_error
      end
    end
  end

  describe '.render' do
    describe 'hard-coded guid' do
      it 'should render for a predefined size' do
        predefined_size_test_cases.each do |size, expected_value|
          liquid = "{% smugmug_url dimensions: #{size} guid: #{guid} %}"
          rendered = Liquid::Template.parse(liquid).render
          expect(rendered).to include expected_value
        end
      end

      it 'should render for a custom size' do
        custom_size_test_cases.each do |size, expected_value|
          liquid = "{% smugmug_url dimensions: #{size} guid: #{guid} %}"
          rendered = Liquid::Template.parse(liquid).render
          expect(rendered).to include expected_value
        end
      end
    end

    describe 'guid from context' do
      it 'should render for a predefined size' do
        predefined_size_test_cases.each do |size, expected_value|
          liquid = "{% smugmug_url dimensions: #{size} guid: my_guid %}"
          rendered = Liquid::Template.parse(liquid).render 'my_guid' => guid
          expect(rendered).to include expected_value
        end
      end

      it 'should render for a custom size' do
        custom_size_test_cases.each do |size, expected_value|
          liquid = "{% smugmug_url dimensions: #{size} guid: my_guid %}"
          rendered = Liquid::Template.parse(liquid).render 'my_guid' => guid
          expect(rendered).to include expected_value
        end
      end
    end
  end
end

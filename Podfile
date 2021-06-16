# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def marvelCharacters_pods
  pod 'SDWebImage'
  pod 'Moya'
  pod 'CollapsibleTableSectionViewController', '~> 2.0.1'

end

target 'MarvelCharacters' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  marvelCharacters_pods

  target 'MarvelCharactersTests' do
    inherit! :search_paths
    marvelCharacters_pods
  end

  target 'MarvelCharactersUITests' do
    marvelCharacters_pods
  end

end

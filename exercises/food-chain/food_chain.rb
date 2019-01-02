module FoodChain
  def self.song
    know_an_old_lady = ->(a) { "I know an old lady who swallowed a %s.\n" % a }
    swallowed = ->(a,b) { "She swallowed the %s to catch the %s.\n" % [a, b] }

    perhaps = "I don't know why she swallowed the fly. Perhaps she'll die.\n"

    fly = know_an_old_lady.call('fly') + perhaps

    spider = know_an_old_lady.call('spider') +
      "It wriggled and jiggled and tickled inside her.\n" +
      swallowed.call('spider', 'fly') +
      perhaps

    bird = know_an_old_lady.call('bird') +
      "How absurd to swallow a bird!\n" +
      swallowed.call('bird', 'spider that wriggled and jiggled and tickled inside her') +
      spider.lines.drop(2).join

    cat = know_an_old_lady.call('cat') +
      "Imagine that, to swallow a cat!\n" +
      swallowed.call('cat', 'bird') +
      bird.lines.drop(2).join

    dog = know_an_old_lady.call('dog') +
      "What a hog, to swallow a dog!\n" +
      swallowed.call('dog', 'cat') +
      cat.lines.drop(2).join

    goat = know_an_old_lady.call('goat') +
      "Just opened her throat and swallowed a goat!\n" +
      swallowed.call('goat', 'dog') +
      dog.lines.drop(2).join

    cow = know_an_old_lady.call('cow') +
      "I don't know how she swallowed a cow!\n" +
      swallowed.call('cow', 'goat') +
      goat.lines.drop(2).join

    horse = know_an_old_lady.call('horse') + "She's dead, of course!\n"

    [fly, spider, bird, cat, dog, goat, cow, horse].join("\n")
  end
end

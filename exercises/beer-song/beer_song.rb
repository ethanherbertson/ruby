class BeerSong
  NORMAL_VERSE = <<EOS.freeze
%{bottle_phrase_start} of beer on the wall, %{bottle_phrase_start} of beer.
Take one down and pass it around, %{bottle_phrase_end} of beer on the wall.
EOS
  LAST_BOTTLE_VERSE = <<EOS.freeze
1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
EOS
  EMPTY_SHELF_VERSE = <<EOS.freeze
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
EOS

  def verse(bottle_count)
    raise ArgumentError unless bottle_count >= 0 && bottle_count <= 99 && bottle_count.integer?
    return LAST_BOTTLE_VERSE if bottle_count == 1
    return EMPTY_SHELF_VERSE if bottle_count == 0

    format(NORMAL_VERSE,
      bottle_phrase_start: "#{bottle_count} bottles",
      bottle_phrase_end: "#{bottle_count - 1} bottle#{bottle_count == 2 ? '' : 's'}"
    )
  end

  def verses(start, stop)
    (stop..start)
      .to_a
      .reverse
      .map {|i| verse(i)}
      .join("\n")
  end
end

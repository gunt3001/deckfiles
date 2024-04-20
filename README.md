# deckfiles

Some setup scripts for my Steam Deck.

Just `cd` to the Desktop on the deck, clone this repo, and chmod the directory.

```shell
cd ~/Desktop
git clone https://github.com/gunt3001/deckfiles.git
find /path/to/directory -type f -name "*.sh" -exec chmod +x {} \; # Set executable bits
```

Scripts will be located under `scripts/`.

To run from game mode, use the convenient GUI menu built using `zenity` by running `scripts-menu.sh`. You can add that script to Steam via Non-Steam Game option.
# Create a release

  1. Update changelog in `README.md`
  2. Update version in `plugin/uncrustify.vim`
  3. Convert `README.md` to help file: `make doc`
  4. Commit current version: `hg commit -m 'prepare release vX.Y.Z'`
  5. Tag version: `hg tag vX.Y.Z -m 'tag release vX.Y.Z'`
  6. Push release to [GitHub]:
    - `hg push git+ssh://git@github.com:embear/vim-uncrustify.git`
  7. Create a Vimball archive: `make package`
  8. Update [VIM online]

[GitHub]: https://github.com/embear/vim-uncrustify
[VIM online]: http://www.vim.org/scripts/script.php?script_id=5684

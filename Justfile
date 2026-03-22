@_:
    just --list --unsorted

[group("lifecycle")]
clean:
    rm -rf \
        public \
        resources \
        megalinter-reports
    find . -name ".DS_Store" -type f -delete

[group("lifecycle")]
update-blowfish:
    git submodule update --remote --merge

[group("qa-extra")]
megalinter:
    npx mega-linter-runner --flavor cupcake --env "MEGALINTER_CONFIG=.github/linters/.megalinter.yml"

[group("run")]
serve:
    open http://localhost:1313
    hugo server --disableFastRender --noHTTPCache

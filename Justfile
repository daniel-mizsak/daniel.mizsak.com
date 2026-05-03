@_:
    just --list --unsorted

[group("lifecycle")]
clean:
    rm -rf \
        public \
        resources \
        themes/blowfish \
        megalinter-reports
    find . -name ".DS_Store" -type f -delete

[group("lifecycle")]
init:
    git submodule sync --recursive
    git submodule update --init --recursive

[group("lifecycle")]
update:
    git submodule sync --recursive
    git submodule update --init --recursive --remote --merge

[group("lifecycle")]
fresh: clean init

# https://blowfish.page/docs/advanced-customisation/#run-the-tailwind-compiler
[group("lifecycle")]
compile-tailwind:
    node ./themes/blowfish/node_modules/@tailwindcss/cli/dist/index.mjs \
    -c ./themes/blowfish/tailwind.config.js \
    -i ./themes/blowfish/assets/css/main.css \
    -o ./assets/css/compiled/main.css --jit

[group("qa-extra")]
megalinter:
    just clean
    npx mega-linter-runner --flavor cupcake --env "MEGALINTER_CONFIG=.github/linters/.megalinter.yml"
    just init

[group("qa-extra")]
prek:
    prek run --all-files

[group("run")]
serve:
    open http://localhost:1313
    hugo server --disableFastRender --noHTTPCache

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
init:
    git submodule update --remote --merge

# https://blowfish.page/docs/advanced-customisation/#run-the-tailwind-compiler
[group("lifecycle")]
compile-tailwind:
    node ./themes/blowfish/node_modules/@tailwindcss/cli/dist/index.mjs \
    -c ./themes/blowfish/tailwind.config.js \
    -i ./themes/blowfish/assets/css/main.css \
    -o ./assets/css/compiled/main.css --jit

[group("qa-extra")]
megalinter:
    npx mega-linter-runner --flavor cupcake --env "MEGALINTER_CONFIG=.github/linters/.megalinter.yml"

[group("run")]
serve:
    open http://localhost:1313
    hugo server --disableFastRender --noHTTPCache

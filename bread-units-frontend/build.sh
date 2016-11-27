# Replace current folder in stack.yaml
cp stack.yaml.tmpl stack.yaml
sed -i 's?CURRENT_FOLDER?'`pwd`'?' stack.yaml

stack setup
stack install "$@"

# copy results
rm -rf ../bread-units-backend/static/all.js
cp $(stack path --local-install-root)/bin/bread-units-frontend.jsexe/all.js ../bread-units-backend/static/all.js
